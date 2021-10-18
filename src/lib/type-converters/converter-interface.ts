import { Definition, Field, Type } from '../model';

export interface IConverter {
  converts: Type;
  buildConversionExpression(field: Field, def?: Definition): string;
}
