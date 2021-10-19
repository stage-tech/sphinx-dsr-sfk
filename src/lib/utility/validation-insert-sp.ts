export function minSizeValidation(modelName: string, fieldName: string, minSize: number): string {
  return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::number >= ${minSize}, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'LESS_THAN_MIN_SIZE')))`;
}

export function maxSizeValidation(modelName: string, fieldName: string, maxSize: number): string {
  return `IFF(${fieldName}[0] is null, null, IFF(${fieldName}[0]::number <= ${maxSize}, null, OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'GREATER_THAN_MAX_SIZE')))`;
}

export function dateTimeValidation(modelName: string, fieldName: string, allowedValues: string[]): string {
  return multipleValidation(modelName, fieldName, allowedValues, 'TRY_TO_TIMESTAMP', 'DATETIME');
}

export function dateValidation(modelName: string, fieldName: string, allowedValues: string[]): string {
  return multipleValidation(modelName, fieldName, allowedValues, 'TRY_TO_DATE', 'DATE');
}

export function timeValidation(modelName: string, fieldName: string, allowedValues: string[]): string {
  return multipleValidation(modelName, fieldName, allowedValues, 'TRY_TO_TIME', 'TIME');
}

export function durationValidation(modelName: string, fieldName: string, allowedValues: string[]): string {
  return multipleValidation(modelName, fieldName, allowedValues, 'TRY_TO_TIME', 'DURATION');
}

export function multipleValidation(
  modelName: string,
  fieldName: string,
  allowedValues: string[],
  func: string,
  type: string,
): string {
  let validationString = `IFF(${fieldName}[0] is null, null, `;
  for (const index in allowedValues) {
    const allowedValue = allowedValues[index];
    validationString += `\n      IFF(${func}(${fieldName}[0]::string, '${allowedValue}') is not null, null, `;
  }
  validationString += `OBJECT_CONSTRUCT('FIELD', '${fieldName}', 'LINE_INDEX', LINE_INDEX::integer, 'RECORD_TYPE', '${modelName}', 'FIELD_VALUE', ${fieldName}, 'VIOLATION_TYPE', 'NOT_${type}'))`;
  allowedValues.forEach((f) => (validationString += ')'));
  return validationString;
}
