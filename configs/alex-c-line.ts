import type { AlexCLineConfig } from "alex-c-line/configs";

const alexCLineConfig: AlexCLineConfig = {
  preCommit: {
    packageManager: "pnpm",
    steps: ["format", "lint"],
  },
};

export default alexCLineConfig;
