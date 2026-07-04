# Change Request

This is a request for a change to infrastructure by AlexMan123456. If this gets accepted it will trigger a new deployment to apply the change. Please see more details below.

## Change reason

Manually grant secrets access in AWS

## Change description

We need to give the role permissions to run the plan, but we need to run the plan to give the role permissions. As such, I have manually added permissions for now, and the next apply should then correct it to be less broad than what is currently set manually
