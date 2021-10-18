import fs from 'fs';
import path from 'path';

import { replaceAll } from '../utility/utility';

export enum ExecutionType {
  ERROR_BUBBLING = 'ERROR_BUBBLING',
  ERROR_TRAPPED = 'ERROR_TRAPPED',
}

interface StoredProcedureParameter {
  name: string;
  type: string;
}

export interface ProcedureProps {
  Name: string;
  returnType: string;
  parameters?: StoredProcedureParameter[];
  body: string;
  executionType: ExecutionType;
}

export class StoredProcedureWrapper {
  wrap(props: ProcedureProps): string {
    const templatePath = path.resolve(`src/lib/procs/proc.${props.executionType.toLocaleLowerCase()}.template.sql`);
    const parametersSignature = props.parameters?.map((p) => `${p.name} ${p.type}`).join(',') ?? '';
    const substitutions: { [key: string]: string } = {
      PROC_NAME: props.Name,
      PROC_RETURN_TYPE: props.returnType,
      PROC_BODY: props.body,
      PROC_PARAMETERS: parametersSignature,
    };
    const template = fs.readFileSync(templatePath, 'utf-8');
    let output = template;
    if (substitutions != undefined) {
      for (const key in substitutions) {
        output = replaceAll(output, `{{${key}}}`, substitutions[key]);
      }
    }
    return output;
  }
}
