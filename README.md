# Ruboty::Feed

Ruboty plug-in to subscribe RSS feed (along with [ruboty-cron](https://github.com/r7kamura/ruboty-cron)).

## Usage

Fetch RSS/Atom Feed by providing a feed's URL.

```
@ruboty subscribe <feed url>
```

However, as you usually want to subscribe a feed for fetching periodically, use this together with ruboty-cron is recommended.

```
@ruboty add job "0 * * * *" @ruboty subscribe <feed url>
```
