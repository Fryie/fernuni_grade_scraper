# GradeScraper
Find out if your exam at Fernuni Hagen has finally been graded.

This is my first Elixir program, so don't expect anything special. ;)

## Prerequisites
Need to have `selenium-webserver` and `elixir` installed. On a mac:
```
brew install selenium-webserver-standalone
brew install elixir
```

On Linux, use your favourite package manager. On Windows, you're on your own.

You'll also need to run
```
mix local.hex
mix local.rebar
```
once initially.

## Select exam
Open up `lib/grade_scraper.ex` and exchange the `@exam_search_string` constant (currently, it's checking for the probability module). Basically, the scraper will just check whether that string appears somewhere on the grade listing page.

## Run
Issuing `./start` should be enough. This starts a selenium process in the background and runs the scraper against it. It will spin up a browser (haven't been able to make it headless yet), so be prepared for that.

You will also be asked for your credentials - these aren't stored anywhere though.

## Store credentials
If you're tired of inputting your credentials all the time, you can (at your own risk!) store them in the `FERNUNI_POS_USERNAME` and `FERNUNI_POS_PASSWORD` environment variables (e.g. in your shell startup script).

## TODO
- actually output the grade instead of just alerting you that there is a grade
- make exam title configurable more easily (parameter maybe?)
- run this in headless mode somehow?
