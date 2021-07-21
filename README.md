<p align="center">
  <img src="https://habrastorage.org/webt/bm/x9/e6/bmx9e60tk6apotudqs6ghxvgyuk.png" alt="logo" width="420" />
</p>

# [RoadRunner][roadrunner] ⇆ [Lumen][laravel] bridge boilerplate

[![License][badge_license]][link_license]
![badge_php_v]
![badge_lumen_v]

Example of using [RoadRunner][roadrunner] webserver for [Lumen][laravel] application.

## Usage

Clone this repo by:

```shell script
$ git clone git@github.com:mobypolo/docker-roadrunner-lumen-clean-boilerplate.git .
```
Then simple run:
```shell script
$ make up
``` 
That's all!

Feel free to change `.rr.local.yaml` config in your work directory ([full example can be found here][roadrunner_config]).

You may see worked instances of [RR][roadrunner] by:

```shell script
$ rr workers -i -c /app/.rr.yaml
```

### Remember about known issues

#### Controller constructors

You should avoid to use HTTP controller constructors _(created or resolved instances in a constructor can be shared between different requests)_. Use dependencies resolving in a controller **methods** instead.

Bad:

```php
<?php

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Http\Controllers\Controller;

class UserController extends Controller
{
    /**
     * The user repository instance.
     */
    protected $users;

    /**
     * @var Request
     */
    protected $request;

    /**
     * @param UserRepository $users
     * @param Request        $request
     */
    public function __construct(UserRepository $users, Request $request)
    {
        $this->users   = $users;
        $this->request = $request;
    }

    /**
     * @return Response
     */
    public function store(): Response
    {
        $user = $this->users->getById($this->request->id);

        // ...
    }
}
```

Good:

```php
<?php

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Http\Controllers\Controller;

class UserController extends Controller
{
    /**
     * @param  Request        $request
     * @param  UserRepository $users
     *
     * @return Response
     */
    public function store(Request $request, UserRepository $users): Response
    {
        $user = $users->getById($request->id);

        // ...
    }
}
```

## Support

If you find any package errors or want to help, please, [make an issue][link_create_issue] in a current repository.

## License

MIT License (MIT). Please see [`LICENSE`](./LICENSE) for more information. Fully inspired by [eplightning](https://github.com/eplightning) and [Spiral Scout](https://spiralscout.com).

[badge_packagist_version]:https://img.shields.io/packagist/v/spiral/roadrunner-laravel.svg?maxAge=180
[badge_php_version]:https://img.shields.io/packagist/php-v/spiral/roadrunner-laravel.svg?longCache=true
[badge_build_status]:https://img.shields.io/github/workflow/status/spiral/roadrunner-laravel/tests?maxAge=30
[badge_coverage]:https://img.shields.io/codecov/c/github/spiral/roadrunner-laravel/master.svg?maxAge=180
[badge_downloads_count]:https://img.shields.io/packagist/dt/spiral/roadrunner-laravel.svg?maxAge=180
[badge_license]:https://img.shields.io/packagist/l/spiral/roadrunner-laravel.svg?maxAge=256
[badge_php_v]:https://img.shields.io/badge/php-8.x-green
[badge_lumen_v]:https://img.shields.io/badge/lumen-8.x-brightgreen
[badge_release_date]:https://img.shields.io/github/release-date/spiral/roadrunner-laravel.svg?style=flat-square&maxAge=180
[badge_commits_since_release]:https://img.shields.io/github/commits-since/spiral/roadrunner-laravel/latest.svg?style=flat-square&maxAge=180
[badge_issues]:https://img.shields.io/github/issues/spiral/roadrunner-laravel.svg?style=flat-square&maxAge=180
[badge_pulls]:https://img.shields.io/github/issues-pr/spiral/roadrunner-laravel.svg?style=flat-square&maxAge=180
[link_releases]:https://github.com/spiral/roadrunner-laravel/releases
[link_packagist]:https://packagist.org/packages/spiral/roadrunner-laravel
[link_build_status]:https://github.com/spiral/roadrunner-laravel/actions
[link_coverage]:https://codecov.io/gh/spiral/roadrunner-laravel/
[link_changes_log]:https://github.com/spiral/roadrunner-laravel/blob/master/CHANGELOG.md
[link_issues]:https://github.com/spiral/roadrunner-laravel/issues
[link_create_issue]:https://github.com/mobypolo/docker-roadrunner-lumen-clean-boilerplate/issues/new
[link_commits]:https://github.com/spiral/roadrunner-laravel/commits
[link_pulls]:https://github.com/spiral/roadrunner-laravel/pulls
[link_license]:https://github.com/mobypolo/roadrunner-lumen/blob/main/LICENSE
[getcomposer]:https://getcomposer.org/download/
[roadrunner]:https://github.com/spiral/roadrunner
[roadrunner_config]:https://github.com/spiral/roadrunner-binary/blob/master/.rr.yaml
[laravel]:https://lumen.laravel.com/
[laravel_events]:https://laravel.com/docs/events
[roadrunner-cli]:https://github.com/spiral/roadrunner-cli
[roadrunner-binary-releases]:https://github.com/spiral/roadrunner-binary/releases
[#10]:https://github.com/spiral/roadrunner-laravel/issues/10