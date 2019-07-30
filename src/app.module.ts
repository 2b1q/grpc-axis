import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';

import { RedisModule } from 'nestjs-redis';

import { VehicleExploitationModule } from './vehicle-exploitation/vehicle-exploitation.module';

const MONGO_URI = process.env.URI
  ? process.env.URI
  : 'mongodb://localhost/snapshots';
const REDIS_HOST = process.env.REDIS_HOST
  ? process.env.REDIS_HOST
  : 'localhost';
const REDIS_PORT = process.env.REDIS_PORT ? process.env.REDIS_PORT : 6379;

@Module({
  imports: [
    VehicleExploitationModule,
    MongooseModule.forRoot(MONGO_URI, {
      useNewUrlParser: true,
    }),
    RedisModule.register({
      url: `redis://${REDIS_HOST}:${REDIS_PORT}`,
    }),
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
