# awsm

[![Build Status](https://travis-ci.org/GovWizely/awsm.svg?branch=master)](https://travis-ci.org/GovWizely/awsm/)
[![Code Climate](https://codeclimate.com/github/GovWizely/awsm/badges/gpa.svg)](https://codeclimate.com/github/GovWizely/awsm)
[![Test Coverage](https://codeclimate.com/github/GovWizely/awsm/badges/coverage.svg)](https://codeclimate.com/github/GovWizely/awsm/coverage)

awsm (pronounced "awesome") helps you manage your AWS services.

It allows you to execute a chain of AWS operations using AWS SDK.

## Requirements

- Ruby 2.2.7 and up

## Installation

```unix
$ gem install 'https://github.com/GovWizely/awsm.git'
```

## Usage

```unix
$ awsm

$ awsm help manage
```

## Setup

- Create a new project directory

- In the project directory, create `credentials.yml` with your AWS credentials keys

  See [credentials.yml](https://github.com/GovWizely/awsm/blob/master/spec/fixtures/project/credentials.yml)

- Create your JSON config file

  See [create_load_balancer.json](https://github.com/GovWizely/awsm/blob/master/spec/fixtures/project/create_load_balancer.json)

- Create your YAML variables file

  If your JSON actions filename is `create_load_balancer.json`, the variables file should be `create_load_balancer_variables.yml`

  See [create_load_balancer_variables.yml](https://github.com/GovWizely/awsm/blob/master/spec/fixtures/project/create_load_balancer_variables.yml)

- Run your config with the following command:
  ```unix
    bundle exec rake manage[path/to/config/file]
  ```

