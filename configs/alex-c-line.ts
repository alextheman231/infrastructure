import type { AlexCLineConfig } from "alex-c-line/configs";
import { scripts } from "package.json" with { type: "json" };

const alexCLineConfig: AlexCLineConfig<keyof typeof scripts> = {
  preCommit: {
    packageManager: "pnpm",
    steps: ["format", "lint"],
  },
  template: {
    pullRequest: {
      category: "infrastructure",
      infrastructureProvider: "Terraform",
      requireConfirmationFrom: "AlexMan123456",
    },
  },
};

export default alexCLineConfig;
