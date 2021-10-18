import { Definition, Field, Type } from '../../model';
import { ArrayMaximumSizeValidation, ArrayMinimumSizeValidation, ArrayMustBeExplicit } from './array';
import { BooleanValidation } from './boolean';
import { DateTimeValidation, DateValidation, DurationValidation, TimeValidation } from './date-and-time';
import { EnumValidation } from './enum';
import { NumericDecimal, NumericInteger, NumericMaximum, NumericMinimum } from './numeric';
import { RequiredFieldValidation } from './required';
import { StringAllowedValuedValidation, StringPatternValidation } from './string';

export interface IValidationStrategy {
  getSqlValidationRule(field: Field, def?: Definition): string | undefined;
}

export const ValidationStrategies: IValidationStrategy[] = [
  new ArrayMustBeExplicit(),
  new ArrayMaximumSizeValidation(),
  new ArrayMinimumSizeValidation(),
  new BooleanValidation(),
  new DateTimeValidation(),
  new DateValidation(),
  new TimeValidation(),
  new DurationValidation(),
  new EnumValidation(),
  new NumericInteger(),
  new NumericDecimal(),
  new NumericMaximum(),
  new NumericMinimum(),
  new StringAllowedValuedValidation(),
  new StringPatternValidation(),
  new RequiredFieldValidation(),
];
