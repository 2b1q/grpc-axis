import {
  Injectable,
  CanActivate,
  ExecutionContext,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';

import { TokenStore } from './token.store';
import { User } from './user.interface';
import { RpcException } from '@nestjs/microservices';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(private tokenStore: TokenStore) {}
  async canActivate(context: ExecutionContext): Promise<boolean> {
    const req = context.switchToHttp().getRequest();
    // HTTP call
    if (req.headers) {
      // check is Authorization header in client request from ExecutionContext
      if (!req.headers.authorization) {
        return false;
      }
      // attach authorized User to the req.user object.
      req.user = await this.getHttpToken(req.headers.authorization);
      return true;
    } else {
      const args = context.getArgs();
      // gRPC call
      const metadata = args[1];
      // check if metadata passed
      if (!metadata) {
        return false;
      }
      // check if token passed
      if (
        !metadata._internal_repr.hasOwnProperty('token') ||
        metadata._internal_repr.token.length === 0
      ) {
        return false;
      }
      const token = metadata._internal_repr.token;
      req.user = await this.getGrpcToken(token);
      return true;
    }
  }

  // validate auth token from gRPC request
  private async getGrpcToken(token: string): Promise<User> {
    const context = 'AuthGuard gRPC API';
    Logger.warn(`Got Authorization header from client: ${token}`, context);
    // retreive client UUID from Redis token store by token
    const uuid = await this.tokenStore.getClientUuidByToken(token);
    if (!uuid) {
      Logger.error(
        `gRPC token ${token} validation failed. Client not found`,
        null,
        'AuthGuard',
      );
      throw new RpcException({
        code: 16, // UNAUTHENTICATED
        message: 'Token validation failed. Client not found',
      });
    }
    return { uuid, token };
  }

  // validate auth token from HTTP Request
  private async getHttpToken(auth: string): Promise<User> {
    const context = 'AuthGuard REST API';
    Logger.warn(`Got Authorization header from client: ${auth}`, context);

    // check Token word
    if (auth.split(' ')[0] !== 'Token') {
      throw new HttpException(
        'Invalid token. Unable to pass Token',
        HttpStatus.FORBIDDEN,
      );
    }
    // get token
    const token = auth.split(' ')[1];
    Logger.log(`Got token ${token} from client`, context);

    // check if token exists in Authorization header
    if (!token) {
      throw new HttpException('Invalid token', HttpStatus.FORBIDDEN);
    }
    // retreive client UUID from Redis token store by token
    const uuid = await this.tokenStore.getClientUuidByToken(token);
    if (!uuid) {
      throw new HttpException(
        'Token validation failed. Client not found',
        HttpStatus.FORBIDDEN,
      );
    }
    return { token, uuid };
  }
}
