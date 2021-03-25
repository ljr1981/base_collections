# Eiffel Base Collection
An Eiffel library for collections similar to Java/C#

## Backgrounder
The process of creating this library started with a challenge from a Java colleague who rightfully complained that the available Eiffel libraries seemed to be very lacking (this is demonstrably true). The subsequent discovery demonstrated not only the truth of this statement, but a potential way forward.

At first—it seemed right to simply start building an Eiffel counterpart to Java's Treemap as TREE_MAP. However, it did not take long to get bogged down in trying to reinvent the wheel. Thankfully, through suggestions from my Java colleague and others in the Eiffel Community, I was led into the Gobo library, where I was introduced to the DS_RED_BLACK_TREE of the Gobo Structure library. This formed a very quick basis for building out an Eiffel TREE_MAP.

The resulting code (so far) appears promising as a direct answer to this one class in Java, coded in Eiffel. Working through the Java Treemap API Specification has been remarkably painless. It reveals just how close Eiffel is in the catch-up game to Java. The sore lacking is the programming resources to make it happen quickly and accurately. I certainly lack a sufficient knowledge-base to tackle the matter alone. The solution will be a combination of people with deep Java library knowledge coupled with people with deep Eiffel library knowledge who can not only help guide the process, but even code the really sticky/tricky bits, where needed.

## Hall of Shame
So, far the only class that is "on-its-way" is the TREE_MAP class (we have to start somewhere, right?). Over time, hopefully we can turn shame into fame!
