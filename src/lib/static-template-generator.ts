import fs from 'fs';
import path from 'path';

import { IGenerator } from './interfaces';
import { replaceAll } from './utility/utility';

export class StaticTemplateGenerator implements IGenerator {
  constructor(
    private templatePath: string,
    public outputPath: string,
    private substitutions?: { [key: string]: string },
  ) {}
  generate(): string {
    const templatePath = path.resolve(this.templatePath);

    const template = fs.readFileSync(templatePath, 'utf-8');
    let output = template;
    if (this.substitutions != undefined) {
      for (const key in this.substitutions) {
        output = replaceAll(output, `%${key}%`, this.substitutions[key]);
      }
    }
    return output;
  }
}
