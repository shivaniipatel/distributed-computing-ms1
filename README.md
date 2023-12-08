# Overview

This codebase was created to demonstrate a fully fledged application built with Angular that interacts with an actual backend server including CRUD operations, authentication, routing, pagination, and more. 

### Making requests to the backend API

For convenience, we are using a live API server running at https://conduit.productionready.io/api for the application to make requests against.

If you want to change the API URL to a local server, simply edit `src/environments/environment.ts` and change `api_url` to the local server's URL (i.e. `localhost:3000/api`). Please note you will probably need to use a proxy in order to avoid Cross-Origin Resource (CORS) issues. 


# Local Setup

Make sure you have the [Angular CLI](https://github.com/angular/angular-cli#installation) installed globally. We use [Yarn](https://yarnpkg.com) to manage the dependencies, so we strongly recommend you to use it. you can install it from [Here](https://yarnpkg.com/en/docs/install), then run `yarn install` to resolve all dependencies (might take a minute).

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

### Building the project

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `-prod` flag for a production build.

# Installation and Setup

1. AWS Setup:
* Create an ECR Repository:
* Create an ECR repository in AWS where you'll store your Docker images.

* Set Up a Kubernetes Cluster:
  * Set up a Kubernetes cluster on AWS. You can use Amazon EKS (Elastic Kubernetes Service) for this.

2. Jenkins Setup:
* Install Jenkins Plugins:
  * Make sure Jenkins has the necessary plugins installed for AWS, Docker, and Kubernetes.

* Configure AWS Credentials in Jenkins:
  * In Jenkins, go to "Manage Jenkins" > "Manage Credentials."
  * Add AWS credentials with the necessary permissions for ECR and Kubernetes.

3. GitHub Setup:
* Generate Jenkins API Token:
  * In Jenkins, go to "Manage Jenkins" > "Manage Users" > select your user.
  * Under "API Token," click "Add new Token" and generate a token.

* Install GitHub Plugin in Jenkins:
  * In Jenkins, go to "Manage Jenkins" > "Manage Plugins."
  * Navigate to the "Available" tab, search for "GitHub Integration," and install the plugin.

* Configure Jenkins Credentials:
  * Go to "Manage Jenkins" > "Manage Credentials."
  * Add a new secret text credential with your GitHub API token.

4. Jenkins Job Configuration:
* Create a Jenkins Job:
  * Create a new Jenkins job (Freestyle project or Pipeline).

* Configure GitHub Integration:
  * In your Jenkins job configuration, find the "GitHub project" section.
  * Enter the URL of your GitHub repository.

* Set Up Source Code Management:
  * Choose your version control system (e.g., Git).
  * Enter the repository URL.

* Set Up Build Triggers:
  * Under "Build Triggers," check the option "GitHub hook trigger for GITScm polling."

5. GitHub Webhook Configuration:
* Go to Your GitHub Repository:
  * Navigate to your GitHub repository.
* Access Webhooks Settings:
  * Go to "Settings" > "Webhooks" > "Add webhook."
* Configure Webhook:
  * Payload URL: http://your-jenkins-server/github-webhook/
  * Content type: application/json
  * Secret: Leave it empty (unless you want to add additional security with a shared secret).
  * SSL verification: Enable it.
  * Events: Select "Just the push event."
* Add Webhook:
  * Click "Add webhook" to save the configuration.

## Test the Setup:
* Push Code to Master:
  * Make a change and push it to the master branch.
* Check Jenkins:
  * Go to Jenkins and navigate to your job.
  * Check the "Build History" to see if a new build is triggered.


# Functionality overview

The example application is a social blogging site (i.e. a Medium.com clone) called "Feedbook". It uses a custom API for all requests, including authentication.

**General functionality:**

- Authenticate users via JWT (login/signup pages + logout button on settings page)
- CRU\* users (sign up & settings page - no deleting required)
- CRUD Articles
- CR\*D Comments on articles (no updating required)
- GET and display paginated lists of articles
- Favorite articles
- Follow other users

**The general page breakdown looks like this:**

- Home page (URL: /#/ )
  - List of tags
  - List of articles pulled from either Feed, Global, or by Tag
  - Pagination for list of articles
- Sign in/Sign up pages (URL: /#/login, /#/register )
  - Uses JWT (store the token in localStorage)
  - Authentication can be easily switched to session/cookie based
- Settings page (URL: /#/settings )
- Editor page to create/edit articles (URL: /#/editor, /#/editor/article-slug-here )
- Article page (URL: /#/article/article-slug-here )
  - Delete article button (only shown to article's author)
  - Render markdown from server client side
  - Comments section at bottom of page
  - Delete comment button (only shown to comment's author)
- Profile page (URL: /#/profile/:username, /#/profile/:username/favorites )
  - Show basic user info
  - List of articles populated from author's created articles or author's favorited articles

<br />

