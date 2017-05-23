# Non Blocking Branching Strategy

## Background

Currently we have a fairly well established branching strategy, as depicted in the image below.

![branching_existing](images/branching_existing.png)

Feature branches are created from the Master branch and merged back into Master, only after the Feature has been signed off by the Product Owner. Every sprint we take a cut of Master and create a Support Branch, in this case Support 3.7

The support branch is used to create the deployable artefacts and remains until such a point where it is no longer needed to provide a hotfix. This means the next sprint can commence on master, in readiness for the next code cut.

## Big Changes

Whilst the approach above is more than adequate for most features. There is a need sometimes to adopt a slightly different branching mechanism, to cater for fundamental changes to the application architecture. The example used here is PHP7, but equally could be any significant change

![branching_proposed](images/branching_proposed.png)

In this instance, whilst making a fundamental change, we do not wish to make that change in such a way that all other work becomes dependent on it. If we operate in the exising manner by merging a change to master, by default makes all future branches become dependent on that change. If, for whatever reason, that fundamental change does not get into production, unpicking the dependencies becomes a significant task.

The proposition is that when Support 3.7 is created, we also create Support 3.8. Any changes encountered during the 3.7 promotion will be reflected in 3.8 by cherry-picking. PHP 7 branches will be created from Support 3.8 and merged back into 3.8 when ready. When code is complete, Support 3.8 will be promoted through the environments as usual. 

Once Support 3.8 is live and stable, Support 3.8 will be merged back into Master, so that normal branching can resume. Doing this with with Support 3.8 means the usual Feature and Master branching strategy can remain in place.

## Benefit

Adopting this approach for large changes means that the new change does not block the delivery pipeline. As long as Master has not been merged, the pipeline is free

## Drawback

It is storing up a merge conflict, post the release. Whilst not ideal, this is preferable to blocking the pipeline

## Cautionary Tales

For the vast majority of feature based changes, there will be no need to merge them into Support 3.8. Puppet and Hiera changes are slightly different however. Any puppet and hiera changes during that period which are merged into master and deployed into production, will also need to be cherry-picked into Support-3.8. The cherry pick should be merged only by the Technical Lead of the Support 3.8 branch. This prevents any configuration regression occurring in the interim period.