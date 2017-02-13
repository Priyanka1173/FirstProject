how to run all tests: cucumber
how to run tests by tag name: cucumber -t @tag_name
how to run tests by line number: cucumber features/Login.feature:5
how to run tests by profile:cucumber -p profile_name

run all test on sause lab:
 SAUCE_USERNAME="<username>" SAUCE_ACCESS_KEY="<key>" SERVER="remote" rake test_sauce

run locally:
 as usual (by tag, by profile), ex:

 SERVER="local" cucumber -t @tag_name
 SERVER="local" cucumber features/Login.feature:5
 SERVER="local" -p profile_name
