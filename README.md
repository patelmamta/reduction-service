# Redaction Service

This is a simple web service built with Ruby on Rails that provides text redaction functionality. It accepts arbitrary text via a `POST` request and returns the text with certain words redacted, based on a configurable list. It also provides a `GET` endpoint to identify itself.

## Requirements

- Ruby 3.3.4
- Rails 7.2.1

## Features

- **POST /api/v1/redact**: Accepts text and returns the same text with redacted words.
- **GET /api/v1/redact**: Identifies the service as "Redaction Service".
- Configurable list of words to redact via environment variables.
- Logs all `POST /redact` requests to a log file, including the original text before redaction.
- Configurable port at runtime.

## Basic Setup and Run Process

Follow these steps to set up and run the application:

### 1. Install Ruby 3.3.4

Ensure that you have `ruby 3.3.4` installed. You can use `rbenv` or `rvm` to manage Ruby versions.

#### Using `rbenv`:
```bash
rbenv install 3.3.4
rbenv global 3.3.4
```

#### Using `rvm`:
```bash
rvm install 3.3.4
rvm use 3.3.4
```

### 2. Install Rails 7.2.1 by running:
gem install rails -v 7.2.1

### 3. Clone the repository and navigate into the project directory:
git clone https://github.com/patelmamta/reduction-service.git
cd redaction-service

### 4. Install the required gems by running:
bundle install

### 5. Create a .env file in the project’s root directory to define the list of words that need redaction:
echo 'REDACTION_LIST=confidential,secret,classified' > .env

### 6. Run the server. By default, it will run on port 3000, but you can specify another port with the -p
rails server -p 8080

### 7. Postman collection api
https://api.postman.com/collections/[SECRETKEY]?access_key=[POSTMANKEY]

### 8. Run test cases by using the below command:
rspec spec/requests/redact_spec.rb

### NOTES:
```bash
1. I used the /api/v1/redact - mentioned versions for API 
2. Set parameter as redact_text to pemit as strong parameters 
3. I changed the response format as well to handle the result, message and status.
4. I implemented test cases for - GET, POST with redacted and without redacted text, and not_found and Internal server error.
5. Also mentioned log file and it will be generated in log/redact_requests.log file.
6. I didn't use serializer because we have only one file.
7. We can also set common method for response format of API but i didn't use it. 
```

### Time
- it took my 2 hours and half hours to create README.md file. 