import { Module } from '@nestjs/common';
import { APP_FILTER } from '@nestjs/core';

import { MongooseModule } from '@nestjs/mongoose';

import { VehicleExploitationModule } from './vehicle-exploitation/vehicle-exploitation.module';
import { HttpErrorFilter } from './shared/http-error.filter';

const MONGO_URI = process.env.URI
  ? process.env.URI
  : 'mongodb://localhost/snapshots';

// resolve app module dependencies
@Module({
  imports: [
    VehicleExploitationModule,
    MongooseModule.forRoot(MONGO_URI, {
      useNewUrlParser: true,
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
