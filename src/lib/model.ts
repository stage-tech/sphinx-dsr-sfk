export interface Definition {
  readonly id: string;
  readonly formatType: string;
  readonly fileFormat?: string;
  readonly version: string;
  readonly description: string;
  readonly models: { [key: string]: Model };
  readonly enums: { [key: string]: Enum };
}

export interface Model {
  readonly description: string;
  readonly recordSelector?: { position: number; values: string[] };
  readonly fields: Field[];
}

export interface Field extends SubField {
  readonly position: number;
  readonly name: string;
}

export interface SubField extends Validation {
  readonly type: Type;
  readonly typeRef?: string;
  readonly typeOpt?: { [key: string]: any };
  readonly items?: SubField;
}

export interface TypeOptions {
  readonly delimiter?: string;
  readonly escape?: string;
}

export interface Validation {
  readonly required: boolean;
  readonly allowedValues: string[];
  readonly allowedPattern: string;
  readonly minSize: number;
  readonly maxSize: number;
}

export interface Enum {
  readonly type: Type;
  readonly values: any[];
}

export enum Type {
  STRING = 'string',
  INTEGER = 'integer',
  DECIMAL = 'decimal',
  BOOLEAN = 'boolean',
  DATETIME = 'datetime',
  DATE = 'date',
  TIME = 'time',
  DURATION = 'duration',
  ARRAY = 'array',
  ENUM = 'enum',
}

export enum SFType {
  VARCHAR = 'VARCHAR',
  DATE = 'DATE',
  NUMBER = 'NUMBER',
  DECIMAL = 'DECIMAL',
}
