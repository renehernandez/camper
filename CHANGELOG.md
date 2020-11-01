# Changelog

## [Unreleased](https://github.com/renehernandez/camper/tree/HEAD)

**Implemented enhancements:**

- Implement trash\_todo endpoint [\#58](https://github.com/renehernandez/camper/issues/58)
- Implement trash\_todolist endpoint [\#57](https://github.com/renehernandez/camper/issues/57)
- To-do API is missing update\_todo endpoint [\#49](https://github.com/renehernandez/camper/issues/49)
- update\_todolist endpoint now sends the current description if none is specified [\#62](https://github.com/renehernandez/camper/pull/62)
- Add trash\_todolist endpoint [\#61](https://github.com/renehernandez/camper/pull/61)
- Add trash\_todo endpoint implementation [\#60](https://github.com/renehernandez/camper/pull/60)
- Add recordings api [\#53](https://github.com/renehernandez/camper/pull/53)
- Add update\_todo implementation [\#52](https://github.com/renehernandez/camper/pull/52)

**Fixed bugs:**

- return tag should mention PaginatedResponse instead of Array [\#56](https://github.com/renehernandez/camper/issues/56)
- Get endpoints params need to be set under query field [\#54](https://github.com/renehernandez/camper/issues/54)
- Update endpoints documentation to use PaginatedResponse [\#59](https://github.com/renehernandez/camper/pull/59)
- Fix query string generation in get endpoints [\#55](https://github.com/renehernandez/camper/pull/55)

## [v0.0.10](https://github.com/renehernandez/camper/tree/v0.0.10) (2020-10-30)

**Implemented enhancements:**

- Complete projects api [\#51](https://github.com/renehernandez/camper/pull/51)

## [v0.0.9](https://github.com/renehernandez/camper/tree/v0.0.9) (2020-10-28)

**Implemented enhancements:**

- Split todos and todolists APIs [\#47](https://github.com/renehernandez/camper/pull/47)

**Merged pull requests:**

- Bump rubocop from 0.92.0 to 1.0.0 [\#44](https://github.com/renehernandez/camper/pull/44)

## [v0.0.8](https://github.com/renehernandez/camper/tree/v0.0.8) (2020-10-27)

**Implemented enhancements:**

- Add people API [\#46](https://github.com/renehernandez/camper/pull/46)
- Raise error if resource can't be commented [\#45](https://github.com/renehernandez/camper/pull/45)

## [v0.0.7](https://github.com/renehernandez/camper/tree/v0.0.7) (2020-10-04)

**Implemented enhancements:**

- Implement handling error according to Basecamp 3 API specifications [\#21](https://github.com/renehernandez/camper/issues/21)
- Add ability to complete a Todo [\#12](https://github.com/renehernandez/camper/issues/12)
- Multiple improvements [\#38](https://github.com/renehernandez/camper/pull/38)
- Error handling improvements [\#37](https://github.com/renehernandez/camper/pull/37)

**Documentation:**

- Enable documentation in RubyDoc [\#6](https://github.com/renehernandez/camper/issues/6)
- Add yard documentation [\#41](https://github.com/renehernandez/camper/pull/41)
- Fix gem badge [\#39](https://github.com/renehernandez/camper/pull/39)

**Merged pull requests:**

- Rename add\_comment to create\_comment [\#40](https://github.com/renehernandez/camper/pull/40)
- Bump rubocop from 0.91.0 to 0.92.0 [\#36](https://github.com/renehernandez/camper/pull/36)

## [v0.0.5](https://github.com/renehernandez/camper/tree/v0.0.5) (2020-09-22)

**Implemented enhancements:**

- Enable dependabot [\#22](https://github.com/renehernandez/camper/pull/22)

**Fixed bugs:**

- Implement pagination according to basecamp 3 API [\#20](https://github.com/renehernandez/camper/issues/20)
- Implement pagination according to Basecamp 3 API [\#26](https://github.com/renehernandez/camper/pull/26)

**Merged pull requests:**

- Update actions to point to main branch [\#34](https://github.com/renehernandez/camper/pull/34)
- Apply renames for camper [\#33](https://github.com/renehernandez/camper/pull/33)
- Bump rubocop-performance from 1.7.1 to 1.8.1 [\#32](https://github.com/renehernandez/camper/pull/32)
- Bump rubocop from 0.89.1 to 0.91.0 [\#31](https://github.com/renehernandez/camper/pull/31)
- Bump rubocop from 0.89.0 to 0.89.1 [\#28](https://github.com/renehernandez/camper/pull/28)
- Bump rubocop from 0.88.0 to 0.89.0 [\#27](https://github.com/renehernandez/camper/pull/27)
- Bump rubocop-performance from 1.6.1 to 1.7.1 [\#25](https://github.com/renehernandez/camper/pull/25)
- Bump rack-oauth2 from 1.14.0 to 1.16.0 [\#24](https://github.com/renehernandez/camper/pull/24)
- Bump rubocop from 0.86.0 to 0.88.0 [\#23](https://github.com/renehernandez/camper/pull/23)

## [v0.0.4](https://github.com/renehernandez/camper/tree/v0.0.4) (2020-08-02)

**Implemented enhancements:**

- Add Comments API module [\#11](https://github.com/renehernandez/camper/issues/11)
- Add Comment API Module [\#19](https://github.com/renehernandez/camper/pull/19)
- Refactor usage around the client object [\#18](https://github.com/renehernandez/camper/pull/18)

## [v0.0.3](https://github.com/renehernandez/camper/tree/v0.0.3) (2020-07-26)

**Implemented enhancements:**

- Request a new access token once it expires [\#13](https://github.com/renehernandez/camper/issues/13)
- Retry for new access token [\#16](https://github.com/renehernandez/camper/pull/16)

**Fixed bugs:**

- Remove unreleasedLabel field [\#15](https://github.com/renehernandez/camper/pull/15)

**Documentation:**

- Initial documentation [\#5](https://github.com/renehernandez/camper/issues/5)
- Update docs for retry [\#17](https://github.com/renehernandez/camper/pull/17)
- Add section to categorize documentation changes [\#14](https://github.com/renehernandez/camper/pull/14)
- Docs [\#10](https://github.com/renehernandez/camper/pull/10)

## [v0.0.2](https://github.com/renehernandez/camper/tree/v0.0.2) (2020-07-07)

**Implemented enhancements:**

- Manage release metadata [\#4](https://github.com/renehernandez/camper/issues/4)
- Implement release metadata management [\#9](https://github.com/renehernandez/camper/pull/9)
- Unify Resource and ObjectifiedHash classes [\#3](https://github.com/renehernandez/camper/pull/3)
- Added utility method to transform web URLs [\#2](https://github.com/renehernandez/camper/pull/2)

**Fixed bugs:**

- Added missing import [\#1](https://github.com/renehernandez/camper/pull/1)

## [v0.0.1](https://github.com/renehernandez/camper/tree/v0.0.1) (2020-06-29)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
