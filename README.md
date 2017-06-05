# aws_manager

[![Build Status](https://travis-ci.org/GovWizely/aws_manager.svg?branch=master)](https://travis-ci.org/GovWizely/aws_manager/)
[![Code Climate](https://codeclimate.com/github/GovWizely/aws_manager/badges/gpa.svg)](https://codeclimate.com/github/GovWizely/aws_manager)
[![Test Coverage](https://codeclimate.com/github/GovWizely/aws_manager/badges/coverage.svg)](https://codeclimate.com/github/GovWizely/aws_manager/coverage)

Execute a chain of AWS operations

## Dependencies

- Ruby 2.2.7
- Bundler

## Setup

- Create a new project directory
- In the project directory, create `credentials.yml` with your AWS credentials keys:
  - `access_key_id`
  - `secret_access_key`
- Create your JSON config file
  See [create_load_balancer.json](https://github.com/GovWizely/aws_managerblob/master/spec/fixtures/project/create_load_balancer.json)
- Create your YAML variables file
  If your JSON actions filename is `create_load_balancer.json`, the variables file should be `create_load_balancer_variables.yml`
  See [create_load_balancer_variables.yml](https://github.com/GovWizely/aws_managerblob/master/spec/fixtures/project/create_load_balancer_variables.yml)
- Run your config with the following command:
    ```unix
    bundle exec rake manage[path/to/config/file]
    ```

