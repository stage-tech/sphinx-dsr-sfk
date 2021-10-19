export function minSizeValidation(fieldName: string, minSize: number): string {
  return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::number >= ${minSize}, null, '${fieldName}_LESS_THAN_MIN_SIZE'))`;
}

export function maxSizeValidation(fieldName: string, maxSize: number): string {
  return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::number <= ${maxSize}, null, '${fieldName}_GREATER_THAN_MAX_SIZE'))`;
}

export function dateTimeValidation(fieldName: string, allowedValues: string[]): string {
  return multipleValidation(fieldName, allowedValues, 'TRY_TO_TIMESTAMP', 'DATETIME');
}

export function dateValidation(fieldName: string, allowedValues: string[]): string {
  return multipleValidation(fieldName, allowedValues, 'TRY_TO_DATE', 'DATE');
}

export function timeValidation(fieldName: string, allowedValues: string[]): string {
  return multipleValidation(fieldName, allowedValues, 'TRY_TO_TIME', 'TIME');
}

export function durationValidation(fieldName: string, allowedValues: string[]): string {
  return multipleValidation(fieldName, allowedValues, 'TRY_TO_TIME', 'DURATION');
}

export function multipleValidation(fieldName: string, allowedValues: string[], func: string, type: string): string {
  let validationString = `IFF(${fieldName}[0] is null, null, `;
  for (const index in allowedValues) {
    const allowedValue = allowedValues[index];
    validationString += `\n      IFF(${func}(${fieldName}[0]::string, '${allowedValue}') is not null, null, `;
  }
  validationString += `'${fieldName}_NOT_${type}')`;
  allowedValues.forEach((f) => (validationString += ')'));
  return validationString;
}
