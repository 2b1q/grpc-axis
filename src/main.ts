import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { grpcVehicleOptions } from './grpc.client';
import { Logger } from '@nestjs/common';

const API = process.env.api ? process.env.api : 'grpc';
const HTTP_PORT = process.env.http_port
  ? parseInt(process.env.http_port, 10)
  : 3000;

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  if (API === 'grpc') {
    // init gRPC API
    app.connectMicroservice(grpcVehicleOptions);
    await app.startAllMicroservices();
    Logger.log('gRPC API wiredUP', 'Bootstrap');
  } else {
    // init REST API
    await app.listen(HTTP_PORT);
    Logger.log(`HTTP API running on port ${HTTP_PORT}`, 'Bootstrap');
  }
}
bootstrap();
