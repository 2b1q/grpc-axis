import { Module } from '@nestjs/common';
import { APP_FILTER } from '@nestjs/core';

import { MongooseModule } from '@nestjs/mongoose';
import { RedisModule } from 'nestjs-redis';

import { VehicleExploitationModule } from './vehicle-exploitation/vehicle-exploitation.module';
import { HttpErrorFilter } from './shared/http-error.filter';

const MONGO_URI = process.env.URI
  ? process.env.URI
  : 'mongodb://localhost/snapshots';
const REDIS_HOST = process.env.REDIS_HOST
  ? process.env.REDIS_HOST
  : 'localhost';
const REDIS_PORT = process.env.REDIS_PORT ? process.env.REDIS_PORT : 6379;

// resolve app module dependencies
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
  providers: [
    {
      provide: APP_FILTER,
      useClass: HttpErrorFilter, // global http Exception Error handler filter
    },
  ],
})
export class AppModule {}
