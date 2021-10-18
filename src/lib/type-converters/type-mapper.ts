import { Field, SFType, Type } from '../model';

export interface ITypeMapper {
  isApplicable(field: Field): boolean;
  getSnowFlakeType(field: Field): string;
}

export class StringMapper implements ITypeMapper {
  isApplicable(field: Field): boolean {
    return field.type == Type.STRING;
  }
  getSnowFlakeType(field: Field): string {
    return `${SFType.VARCHAR}${SFTypeMapper.nullableParam(field)}`;
  }
}

export class EnumMapper implements ITypeMapper {
  isApplicable(field: Field): boolean {
    return field.type == Type.ENUM;
  }
  getSnowFlakeType(field: Field): string {
    return `${SFType.VARCHAR}${SFTypeMapper.nullableParam(field)}`;
  }
}

export class IntegerMapper implements ITypeMapper {
  isApplicable(field: Field): boolean {
    return field.type == Type.INTEGER;
  }
  getSnowFlakeType(field: Field): string {
    return `${SFType.NUMBER}${SFTypeMapper.nullableParam(field)}`;
  }
}

export class DecimalMapper implements ITypeMapper {
  isApplicable(field: Field): boolean {
    return field.type == Type.DECIMAL;
  }
  getSnowFlakeType(field: Field): string {
    const precision = field?.typeOpt?.precision ?? 38;
    const scale = field?.typeOpt?.scale ?? 6;
    return `${SFType.DECIMAL}(${precision},${scale})${SFTypeMapper.nullableParam(field)}`;
  }
}

export class DateTimeMapper implements ITypeMapper {
  isApplicable(field: Field): boolean {
    return field.type == Type.DATETIME;
  }
  getSnowFlakeType(field: Field): string {
    return `${SFType.DATE}${SFTypeMapper.nullableParam(field)}`;
  }
}

export class DateMapper implements ITypeMapper {
  isApplicable(field: Field): boolean {
    return field.type == Type.DATE;
  }
  getSnowFlakeType(field: Field): string {
    return `${SFType.DATE}${SFTypeMapper.nullableParam(field)}`;
  }
}

export class TimeMapper implements ITypeMapper {
  isApplicable(field: Field): boolean {
    return field.type == Type.TIME;
  }
  getSnowFlakeType(field: Field): string {
    return `${SFType.DATE}${SFTypeMapper.nullableParam(field)}`;
  }
}

export class SFTypeMapper {
  static getSfDataType(field: Field): string {
    const matchingMapper = TypeMappers.find((mapper) => mapper.isApplicable(field)) ?? new StringMapper();
    return matchingMapper.getSnowFlakeType(field);
  }

  static nullableParam(field: Field): string {
    return field.required ? ' NOT NULL' : '';
  }
}

export const TypeMappers: ITypeMapper[] = [
  new StringMapper(),
  new EnumMapper(),
  new IntegerMapper(),
  new DecimalMapper(),
  new DateTimeMapper(),
  new DateMapper(),
  new TimeMapper(),
];
