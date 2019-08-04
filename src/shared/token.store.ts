import { Injectable, Logger } from '@nestjs/common';
import { RedisService } from 'nestjs-redis';

@Injectable()
export class TokenStore {
  // inject redisService dependencies
  constructor(private readonly redisService: RedisService) {}
  private logger = new Logger('TokenStore');

  async getClientUuidByToken(token: string): Promise<string> {
    let clientUuid: string | undefined;
    // get client UUID from Redis using auth token
    try {
      const client = await this.redisService.getClient();
      clientUuid = await client.get(`wj:auth:token:${token}`);
      this.logger.warn(`clientUuid ${clientUuid} from Redis`);
    } catch (error) {
      this.logger.error(error);
    }
    return clientUuid;
  }
}
