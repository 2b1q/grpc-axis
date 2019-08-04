import { createParamDecorator } from '@nestjs/common';

export const AuthorizedUser = createParamDecorator((data, req) => {
  // access to User context trough decorator
  // req is Express request Object
  return data ? req.user[data] : req.user;
});
