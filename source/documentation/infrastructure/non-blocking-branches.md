# Non Blocking Branching Strategy

## Background

Currently we have a fairly well established branching strategy, as depicted in the image below.

![branching_current](images/branching_current.png)

Feature branches are created from the Master branch and merged back into Master, only after the Feature has been signed off by the Product Owner. Every sprint we take a cut of Master and create a Support Branch, in this case Support 3.8

The support branch is used to create the deployable artefacts and remains until such a point where it is no longer needed to provide a hotfix.

## Big Changes

Whilst the approach above is more than adequate for most features. There is a need sometimes to adopt a slightly different approach, to cater for fundamental changes to the application architecture. The example used here is PHP7, but equally could be any significant change

![branching_proposed](images/branching_proposed.png)

In this instance, whilst making a fundamental change, we do not wish to make that change in such a way that all other work becomes dependent on it. If we operate in the exising manner then merging a change to master, by default makes all future branches dependent on that change. If, for whatever reason, that fundamental change does not get into production, unpicking the dependencies becomes a significant task.

The proposition is that when Support 3.8 is created, we also create Support 3.9. Any changes required to 3.8 will be reflected in 3.9 by cherry-picking. PHP 7 branches will be created from Support 3.9 and merged back into 3.9 when ready. When code is complete, Support 3.9 will be promoted through the environments as usual. 

Once Support 3.9 is live and stable, Support 3.9 will be merged back into Master, so that normal branching can resume. Whilst this is going on with Support 3.9, the usual Feature and Master work can remain the same. 

## Benefit

Adopting this approach for large changes means that the new change does not block the delivery pipeline. As long as Master has not been merged, the pipeline is free

## Drawback

It is storing up a merge conflict, post the release. Whilst not ideal, this is preferable to blocking the pipeline