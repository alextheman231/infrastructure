import { defineAlexCLineConfig } from "alex-c-line/configs"

export default defineAlexCLineConfig({
    createPullRequestTemplate: {
        category: "infrastructure",
        infrastructureProvider: "Terraform",
        requireConfirmationFrom: "AlexMan123456"
    }
})
