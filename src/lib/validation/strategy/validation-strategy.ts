import { Definition, Field } from '../../model';
import { ArrayMaximumSizeValidation, ArrayMinimumSizeValidation, ArrayMustBeExplicit } from './array';
import { BooleanValidation } from './boolean';
import { DateTimeValidation, DateValidation, DurationValidation, TimeValidation } from './date-and-time';
import { EnumValidation } from './enum';
import { NumericDecimal, NumericInteger } from './numeric';
import { RequiredFieldValidation } from './required';
import { StringAllowedValuedValidation, StringPatternValidation } from './string';

export interface IValidationStrategy {
  getSqlValidationRule(field: Field, modelName?: string, def?: Definition): string | undefined;
}

export const ValidationStrategies: IValidationStrategy[] = [
  new RequiredFieldValidation(),
  new ArrayMustBeExplicit(),
  new NumericInteger(),
  new NumericDecimal(),
  new BooleanValidation(),
  new DurationValidation(),
  new DateTimeValidation(),
  new DateValidation(),
  new TimeValidation(),
  new EnumValidation(),
  new StringPatternValidation(),
  new StringAllowedValuedValidation(),
  new ArrayMinimumSizeValidation(),
  new ArrayMaximumSizeValidation(),
];
