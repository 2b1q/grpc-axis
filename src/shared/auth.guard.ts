import {
  Injectable,
  CanActivate,
  ExecutionContext,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';

import { RedisService } from 'nestjs-redis';

@Injectable()
export class AuthGuard implements CanActivate {
  private readonly redisService: RedisService;

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const req = context.switchToHttp().getRequest();
    // check is Authorization header in client request from ExecutionContext
    if (!req.headers.authorization) {
      return false;
    }
    // validate JWT from Authorization header
    // write decoded JWT to Express req object => user property
    // In the node.js world, it's a common practice to attach the authorized user to the request object.
    // That's why we assumed that request.user (req.user) contains the user instance.
    req.user = await this.getUuid(req.headers.authorization, context);
    return true;
  }

  //  validate JWT helper
  private async getUuid(auth: string, ctx: ExecutionContext) {
    Logger.warn(
      `Got Authorization header from client: ${auth}`,
      ctx.getClass().name + ' => ' + ctx.getHandler().name + ' => AuthGuard',
    );

    // check Token word
    if (auth.split(' ')[0] !== 'Token') {
      throw new HttpException('Invalid token', HttpStatus.FORBIDDEN);
    }
    // check JWT token
    const token = auth.split(' ')[1];

    const tokenKey = `wj:auth:token:${token}`;
    Logger.log(`Got token ${tokenKey} from client', 'Auth Guarg`);

    // get UUID from Redis
    let clientUuid: string | undefined;
    // get client UUID from Redis using auth token
    // try {
    //   const client = await this.redisService.getClient();
    //   clientUuid = await client.get(tokenKey);
    // } catch (error) {
    //   Logger.error(error, null, 'Auth Guard');
    // }
    // check if client already authorized in Redis
    // if (!clientUuid) {
    //   throw new HttpException(
    //     'Token validation failed. Client not found',
    //     HttpStatus.FORBIDDEN,
    //   );
    // }
    return clientUuid;
  }
}
