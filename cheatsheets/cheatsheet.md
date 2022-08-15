# CHEAT SHEET

## GIT :shit:

For a feature be on develop branch and :

`git pull`

to ensure your at the tip of the develop.

Now create branch and checkout on your local machine:

`git checkout -b feature/<name-of-your-branch>`

`git add .`

`git commit -m "the message"`

IF its your first push to the remote repo you'll need to publish the branch so use:

`git push -u origin feature/<name-of-your-branch>`

otherwise once remote branch has been created you can just:

`git push`

when checkout somebody else's branch for review to pull down the remote branch to
your local machine use to test and review:

`git checkout -b feature/<name-of-your-branch>`

merging in changes from develop into your feature branch. (Helps alleviate merge conflicts):

[OPTION 1]
```
// Update develop locally first (this a little more verbose) to ensure develop is at the latest
// version ready for merging into your local feature

git checkout develop
git pull
```
[OPTION 2]
```
// Stay on your feature branch you will be merging develop into this will update all local branches
// from remote, with a full progress report should you wish

git pull --all --progress
```

```
// Now checkout the local feature branch (if you went with option 1) you are going to merge develop into
// once you happy with the merge push you local branch back up to origin

git checkout feature/foo
git merge develop
git push
```

## Stashing

Helpful `git stash` [link](https://www.freecodecamp.org/news/useful-tricks-you-might-not-know-about-git-stash-e8a9490f0a1a/)

***Notable undos!!***

To undo a commit : `git reset --soft HEAD^`

To undo an *add* to staging area : `git reset --soft`

---
---
<br>

## PHPUnit

Make sure your test class `extends PHPUnit\Framework\TestCase`  so the filter works as expected. **MAKE SURE** to remove the `PHPUnit\Framework\`  before committing.

Now you can use the phpunit flag `--filter`

When using PHPUnit locally you will need to make some changes to teh phpunit.xml file and comment out all the those line where Tests have the upper case T in them.

`vendor/bin/phpunit packages/Injector/Api/NewAPIStructure/Tests/Shifts.spec.php --filter testFoo`

---
---
<br>

## Product Request Workflow

Ask yourself is this a further reaching issue other than the individual or bug the ticket is about?

Check the live database for possible other duplications of the error/issue?

Discuss with Community if I've seen an issue in their request to fix something?

Think what my assumptions/or Communities to the fix may cause I problem for the end user?

Will my changes effect the FE discuss with the team/member about their requirements to deal with the changes I make?

---
---
<br>
---
<br>

## Docker & Running Stan and Tests within the Container

---

To "turn docker on" / "spin it up" use `docker compose up` and `docker compose down` for "off".

To check that all is up and running and ready use `docker ps` to check container status

Add the `PHPUnit\Framework\Testcase` to the start of `extends TestCase` MAKE sure to remove before commit!

To open the terminal of a docker container

`docker exec -it <first-5-characters-of-the-container-ID> /bin/sh` - This will usually be the Broadstone API container

You can run normal `php artisan ` commands here

To run PHPStan once inside the Broadstone API container

`vendor/bin/phpstan analyse --memory-limit=-1 --level=5 <packages/Injector/Api/NewAPIStructure/Core/Helpers/StrikeHelper.php>`

To run PHPUnit once inside the Broadstone API container

`vendor/bin/phpunit packages/Injector/Api/NewAPIStructure/Tests/Strike.spec.php`
You could also apply the `--filter` flag to just look at a single method i.e. `vendor/bin/phpunit --filter methodName ClassName path/to/file.php`


# Failed Jobs

SSH into container Broadstone Api container via GCP and make sure your in the latest version of our API

Use cmd `php artisan queue:retry FAILED_JOB_ID_HERE` to re run a failed job from the failed jobs table



# Release Worker API Notes (Hotfix):

http://intranet.broadstoneapp.com/wiki/API_Release  - WIKI Release Notes
http://intranet.broadstoneapp.com/wiki/Works_API_Releases_(Non-Breaking_Changes)

Create a branch of origin/master locally

Once you have the latest master branch and are on it create branch from it with  `git checkout -b hotfix/<branch-name>`

Change commit and update as normal but make sure to update Change Log accordingly !:

```
# v10.14.5 - 15th Aug 2021              // Update version <breaking_change>.<release_update>.<bug_change> - Update the date
- ADDED Notification endpoint to cache  // Update message

```

Once commit pushed create PR as normal (!WARNING make sure to update the branch its merging into as master (NOT Master small m) not the develop branch as it does by default!) and have it
reviewed as P1.

When PR is ready to merge update Orka Works that Hotfix process is about to begin a release. Also check with community that it wont effect an particular demo or be happening at the wrong time for the business!!

Make changes and when ready merge into master and let Gitlab check and deploy as normal.

Check https://gitlab.com/Broadstone-Engage/broadstone-api/-/jobs for completion (Note can take upto 10 mins to show in Gitlab)

Now to add the tag to this branch. In Git graph make sure to use the `Fetch all remotes` icon top right and you should see the hotfix branch you created merged back into master at the top of the tree
ready to tag. Right click and tag branch with new version number. **!Make sure to use lowercase v NOT upper!**

Tick to push tag to remote!

Approx timings of Git Lab deployment in jobs:

- phpstan 3 mins
- unit_tests 1 min
- unit_test_legacy 3 mins
- test_documentation 30 secs
- deploy: 12 mins

Total approx 20 mins from arrival in Gitlab jobs queue

Log into GCP:

**Goto App Engine >> Instances**

Use the following URLs as to what version we are currently on and to know when we have moved over to new version you should see a new instance with the new version number appear.

Fire this URL to check our new instance is spun up and running OK.
https://api.orka.works/v10  = This will update first and check the version number we creating is updated to the correct one means we have a fully deployed instance up and running ready to use.

**NOTE !! Take note of any commands that may need to be ran i.e. php artisan migrate or other injector commands etc. Once instance is in GCP SSH into and run any of these commands.**

If command needs to be ran go to instances section and click on the version drop down and select the version to SSH into. Select the youngest version in the instances below to SSH. Docker PS if you want to get the container
or and use the `docker exec -it gaeapp /bin/sh` (Here at : http://intranet.broadstoneapp.com/wiki/How_To_Access_The_API_Instance). Now you can run artisan commands test with `php artisan migrate:status` if you wish.

All commands? Run check live DB if was involved.

Now we can migrate main URL when it matches! **!!! NOTE - CURRENTLY MIGRATIONS ARE NOT PORTING TO REPLICA DB PLEASE CHECK REPLICA AFTER RELEASE IF WE RAN A MIGRATION !!!** 

Migrate (https://api.orka.works/ = Our API Everything uses this) over to new version - Check the box of the current instance and select `Split Traffic` choose Add version (if the new version doesn't show) and select new
version to migrate to and set to 100% instantly.

Refresh URL until it confirms change.

Update Orka Works slack channel that Hotfix has been released.

Stop old version saves Orka money - Check the box and click STOP! **LEAVE FOR AT LEAST 10MINS BECAUSE OF LOAD BALANCER BEFORE YOU STOP!!**

# Laravel Caching Example

```
// Create our empty response and pass into the cache in case of error we can return this
// with details of error for error handling
$defaultWorkerStatusResponse = $this->defaultWorkerStatusResponse(true);

// If the cache has the response from Orka Check in the last 5 minutes it will use that response
// otherwise it will request Orka Check for an updated worker Status Response. If MQ errors the
// exception thrown will cause us to check the DB for a record to use.
$workerStatusResponse = Cache::remember(
    'job_profile_'. $jobProfile->uuid .'_worker_status_check',  // << The value of the property held in Redis Cache
    300,  // << in seconds so e.g. 5 mins

    // The anonymous function must return something to the cache, and you must pass in most thing to the anonymous function to avoid PHP serialise error
    function () use ($jobProfile, $defaultWorkerStatusResponse) {
        // Get response from OrkaCheck using RabbitMQ
        try {
            return (new MQMessage(null, false))
                ->send('worker', 'users.workerStatus', $jobProfile->uuid);
        } catch (\Exception $e) {
            Log::error('Response from microservice with error: ' . $e->getMessage());

            // Add the details of the error and return
            $defaultWorkerStatusResponse->error_message = $e->getMessage();
            $defaultWorkerStatusResponse->error_code = $e->getCode();
            return $defaultWorkerStatusResponse;
        }
    }
);

```


# Resetting Password in Developer DB

You need the token property for the payload to send to this URL.

```
curl --location --request POST 'localhost:8000/user/password/reset' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "ryan.farrell@orka.group",
    "password": "NewPASSWQORD!",
    "password_confirmation": "NewPASSWQORD!",
    "token": "928135"
}'
```

Dump out the token as below when you hit this endpoint

```
curl --location --request POST 'localhost:8000/user/password/forgot' \
--header 'Content-Type: application/json' \
--data-raw '{
    "username":"ryan.farrell@orka.group"
}'
```

Place the `dump();` as below in the `createNewToken()`:

File and method found in `packages\Injector\Api\User\Helpers\PasswordTokenRepository.php`

```
use Illuminate\Auth\Passwords\DatabaseTokenRepository;
use Illuminate\Auth\Passwords\TokenRepositoryInterface;

class PasswordTokenRepository extends DatabaseTokenRepository implements TokenRepositoryInterface
{
    /**
     * Create a new token for the user.
     *
     * @return string
     */
    public function createNewToken()
    {
        $foo = mt_rand(100000, 999999);
        dump($foo);
        return $foo;
    }
}
```

# Environment Setup Cmd For Individual Terminals
- php artisan serve
- redis-server
- php artisan queue:work --tries=3 --queue=notifications
- php artisan queue:work --tries=3 --queue=default
- // php artisan injector:nats:listen (no longer needed)


# Monthly Payroll

- Complete Checks on the wiki

- Ensure all billing amendments are complete

- Make sure your using the `broadstone-api-monthly-payroll` repo
- Git fetch / pull to update the master branch of this
- .env is setup to run with production. Any changes to .env will need to be applied here
- Set up environment
    - Run `reddis serve` (always first)
    - The web serve `php artisan serve`
    - The queues `php artisan queue:work redis --tries=3 --delay=3`


# Before
docker run --name redis-container -p 6379:6379 redis:5-alpine3.15

# After
docker ps
docker container kill <Container ID>
docker container rm redis-container


# Eager Loading / Query Building
Lets always eager load going forward with query builders. The `$query->with([])`
will let you define relationships to get at the start and with the first hit on the db. And lets force Laravel to stop Lazy Loading later in the endpoint.

See example in file `packages\Injector\Api\Companies\Applications\Repositories\ApplicationRepository.php` in the `ApplicationRepository::getWorkerApplications()` method of its use and why we verbosely bring in all relationships at the start to force the issue of NOT Lazy loading later on.

You can also `dump(get_log_sql($queryLog));` in the `RequestHealthCheckLogger::logEvent()` method to see the individual queries as well as the HealthCheck details in the Lumen log always produced with each request.