import { ArrayConverter } from './array';
import { BooleanConverter } from './boolean';
import { IConverter } from './converter-interface';
import { DateConverter, DateTimeConverter, TimeConverter } from './date-and-time';
import { NumericDecimal, NumericInteger } from './numeric';

export const Converters: IConverter[] = [
  new ArrayConverter(),
  new BooleanConverter(),
  new DateConverter(),
  new DateTimeConverter(),
  new TimeConverter(),
  new NumericInteger(),
  new NumericDecimal(),
];
