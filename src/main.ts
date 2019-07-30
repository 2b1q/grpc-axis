import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { grpcVehicleOptions } from './grpc.client';

async function bootstrap() {
  // init gRPC App
  const app = await NestFactory.create(AppModule);
  app.connectMicroservice(grpcVehicleOptions);
  await app.startAllMicroservices();
}
bootstrap();
