# Credentials

The work is done by M24-RO student  
Anton Kirilin  
a.kirilin@innopolis.university  

# Task 1

The idea of signed commits is kinda simple. It is the same as signing irl. Sometimes you want to verify that the code that you sent somewhere was sent by you.  

But we have an authentication keys! True, but the logic is still the same.  
You can use the same keys for both authentication and signing, however it is not a wise thing to do.  
Authentification is about getting an access  to a repo, being able to interact with it. Meanwhile the signing key is about saying that this code is sourced from a trusted
author.  

For open-source projects, you do not need authentication, so signing comes in handy. For closed projects an imposter has to get both the keys to be able to sent the malicious code. Basically 2-factor authentification.  

Yeah there is also a point about different devices same author e.t.c. but I am not wealthy enough to discuss such matters so idc.

# Task 2

So, when merging bracnhes there are different strategies on how to do that. 

## The default strategy

The default merge startegy creates a new commit on the base (to which we push the changes) branch that has a history of both the base and the feature (from which we push the changes) branches.  
This Type of merging is usually the best practice, because it allows to see how, when and where the changes were applied. Moreover if further changes come from the same branch it is pretty easy to merge them since the history is the same.

## The squish strategy

All the feature commits (the changes) are combined and merged as a single commit to the base branch.  
You will be unable to tell when the changes came, wich will affect the later merges from the same branch. However it can be helpful in scenarious where you have produced a lot of meaningless changes with too few [Hits-of-Code](https://hitsofcode.com/). Or maybe you you have undone changes of the previous commits on the feature branch. Basically, you want to use this commit when you simply want the current changes and do not care about the version control. 

## The rebase strategy

A classical example of the students workflow. Clone a repo, do a lot of changes that it create an entirely new version of the project. Simply rewrite everything in the base branch as if it is the feature. On the positive side, you will have a linear history (if there are no merges or branches from the feature). Also, it is reasonable to do this if you created the branch in the first place, because you were going to make colossal changes that could not be done in a single commit, and the first commit would disrupt the behavior of the base.  Then you start to develop the change on a separate branch, so it does not affect the work already done. In the end you finalize the changes, but you are not going to modify the feature branch and you also want your git be linear hence the rebase option.  

Cons? well you cannot simply undone it, no history and everything that can be related with the rebase option. Generally - bad, but sometimes helpful.