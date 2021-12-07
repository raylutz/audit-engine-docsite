<link rel="icon" type="image/x-icon" href="https://mapper.auditengine.org/assets/images/A.png">
<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngineLogo.png" alt="AuditEngineLogo.png" width='300' />

# Audit Projects -- Overview

AuditEngine performs extremely detailed tabulation audits, that evaluates 100% of the ballot images in the election,
and compares its evaluation of the votes on that ballot image with the official evaluation of the votes on each ballot,
the "Cast Vote Record" (CVR), when it is available.

### Organized by State

To organize our projects, we find that organizing by state makes sense for several reasons. Each state may have slightly different statutes in terms of how voter intent will be evaluated, and the community of interest generally is concerned with many statewide contests which may not be of interest in other states. Also, for presidential contests, the electoral college is concerned with each state.

### Concentrate on the most populous counties

In each state, we try to focus on the most populous counties, because of their obvious importance. Typically, the "80/20 rule", also known as the "Pareto Principle" dictates that we focus primarily on the top counties in the state because a small percentage of the counties will comprise the vast majority of the population in the state. Some states have more concentrated populations than others, so it is not an exact science. With this said, we recognize that with the voting machines being controlled by just a very small number of corporations, there is a risk that a simple hack could modify the results in many of the smaller counties, and still make a big difference. Long term, we want our solution to be deployable to many counties with a minimum of effort.

### Ballot images are required

AuditEngine is primarily a ballot image auditing system, and that means the ballot images must be available. Of the most populous counties in the U.S., 97% use equipment that makes ballot images as a part of their normal processing steps. But not all states provide that ballot images are accessible as public records, and some counties routinely delete the ballot images. For those cases when we offer our services directly to county governments, we can keep the ballot images secured for the vast majority of the ballots unless they require adjudication.

## Current Projects

- [Georgia](GA_2020.md) -- top 27 counties out of 159 (17%) includes 70% of the electorate
    - Recent changes in state law provides that all ballot images are available, and we have obtained more than half of them as of this writing.
- [Wisconsin](WI_2020.md) -- top 18 counties out of 72 (25%) includes 70% of the electorate.  [Donate to WI audits Now!](https://engine.auditengine.org/projects/WI_20201103)
    - Ballot images are public records and counties are cooperative.
- [Florida](FL_2020.md) -- top 20 counties out of 67 (29%) includes 80% of the electorate
    - Ballot images are public records, but many counties do not save them.
    - We have conducted a [three-county case study](audit-results/case_study.md), including Volusia, Collier and St. Lucie counties.
- [Arizona](AZ_2020.md), Maricopa County -- This single county out of 15 includes 60% of the electorate.
    - Ballot images are not easily available but we are still working to get them.
