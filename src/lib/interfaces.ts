export interface IGenerator {
  generate(): string;
  outputPath: string;
}

export interface IRecipe {
  generate(envName: string): { location: string; content: string; generatorName: string }[];
}
