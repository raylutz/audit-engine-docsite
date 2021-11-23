<link rel="icon" type="image/x-icon" href="https://mapper.auditengine.org/assets/images/A.png">
<img src="https://copswiki.org/w/pub/Common/AuditEngine/AuditEngineLogo.png" alt="AuditEngineLogo.png" width='300' />

# AuditEngine -- Audit Projects -- Overview

AuditEngine performs the best type of tabulation audit, because it reviews 100% of the ballot images in the election,
and compares its evaluation of the votes on that ballot image with the official evaluation of the votes on each ballot,
the "Cast Vote Record" (CVR), when it is available.

It makes sense to group our projects generally by state. In each state, we try to focus on the most populous counties,
because of their obvious importance. Typically, the 80/20 rule, the "Pareto Principle" holds true on an approximate basis, 
where a small percentage of the counties will comprise the vast majority of the population in the state. Some states have 
more concentrated populations than others, so it is not an exact science. Also, we recognize that with the voting machines
being controlled by just a very small number of corporations, there is a risk that a simple hack could modify the results 
in many of the smaller counties, and still make a big difference.

Each state may have slightly different statutes in terms of how voter intent will be evaluated. Most states provide that
the marks will be evaluated according to the intent of the voter. So if two bubbles are marked, but one has a big X through it,
we can conclude that the intent of the voter was to cross-out the one they did not want to vote for. But in other states, like
Michigan, they use a strict "as the machine would interpret it" approach. If you mark two ovals, it is an overvote, no matter 
what you might add to it.

To run AuditEngine, we must be able to get to the ballot images. Of the most populous counties in the U.S., 97% use equipment
that makes ballot images as a part of their normal processing steps. But not all states provide that ballot images are 
accessible as public records, and some counties routinely delete the ballot images.

## Current Projects

- Georgia -- top 27 counties out of 159 (17%) includes 70% of the electorate
    - Recent changes in state law provides that all ballot images are available.

- Wisconsin -- top 18 counties out of 72 (25%) includes 70% of the electorate
    - Ballot images are public records and counties are cooperative.

- Florida -- top 20 counties out of 67 (29%) includes 80% of the electorate
    - Ballot images are public records, but many counties do not save them.

- Arizona, Maricopa County -- This single county out of 15 includes 60% of the electorate.
    - Ballot images are not easily available but we are still working to get them.
