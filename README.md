# Stable Marriage

An implementation of the Gale-Shapley algorithm described in [College Admissions and the Stability of Marriage](http://bit.ly/StableMarriage).

Written in Haskell as a personal challenge.

## Problem Statement

Given n men and n women, where each person has ranked all members of the opposite sex in order of preference, marry the men and women together such that there are no two people of opposite sex who would both rather have each other than their current partners. When there are no such pairs of people, the set of marriages is deemed stable.

## Algorithm

- In the first round, first, each unengaged man proposes to the woman he prefers most, and then each woman replies "maybe" to her suitor she most prefers and "no" to all other suitors. She is then provisionally "engaged" to the suitor she most prefers so far, and that suitor is likewise provisionally engaged to her.

- In each subsequent round, first, each unengaged man proposes to the most-preferred woman to whom he has not yet proposed (regardless of whether the woman is already engaged), and then each woman replies "maybe" if she is currently not engaged or if she prefers this man over her current provisional partner (in this case, she rejects her current provisional partner who becomes unengaged). The provisional nature of engagements preserves the right of an already-engaged woman to "trade up" (and, in the process, to "jilt" her until-then partner).

- This process is repeated until everyone is engaged.
