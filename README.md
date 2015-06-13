Iliad
=====

<p align="right">
  <i>
    Rage—Goddess, sing the rage of Peleus' son Achilles,<br/>
    murderous, doomed, that cost the Achaeans countless losses,<br/>
    hurling down to the House of Death so many sturdy souls,<br/>
    great fighters’ souls, but made their bodies carrion,<br/>
    feasts for the dogs and birds,<br/>
    and the will of Zeus was moving toward its end.<br/>
    Begin, Muse, when the two first broke and clashed,<br/>
    Agamemnon lord of men and brilliant Achilles.<br/><br/>
  </i>
  —Homer. The Iliad.
</p>

*Iliad*, the *Implementation of Logical Inference for Adaptive
Devices* is the infrastructure for the *Poem* language.  *Poem* is a
language developed as part of the [ASCENS](http://www.ascens-ist.eu)
project which is particularly well-suited to the development of
awareness mechanisms.  Awareness mechanisms are combinations of
models, reasoners and a sensor system used by an agent at runtime to
"understand" its environment and determine what to do, e.g., by
performing state estimation, learning value functions, or planning
behaviors to reach goals.

The main components of *Iliad* are a blackboard system (Achilles),
logical reasoners (Odysseus), reinforcement learning (Hector), and
constraint solving and non-deterministic computing (Bold Dancer).
Each of these systems is maintained in its own git submodule.  *Iliad*
itself provides a shared package that is useful when all components
are required; it is also possible to load the different components
individually.

A Short Historical Note
-----------------------

Strictly speaking this repository contains version 3 of the *Iliad*
runtime which differs significantly from its predecessors.  The first
two versions of , *Iliad* were developed as unified packages
containing a virtual machine written in Common Lisp that interpreted a
bytecode tailored to the features provided by *Poem*, a compiler from
*Poem* to the bytecode for the VM written in *Poem*, and interfaces to
the Snark theorem prover.  While this enabled us to support all
features of the *Poem* language, we determined that the disadvantages
of this solution outweighed its advantages.

It was clear from the beginning that we would need to integrate other
forms of reasoning besides logical inference into the system.  Since
it is impractical to rewrite the reasoners used by *Iliad*, a binding
between the VM and the reasoner has to be written.  Furthermore, when
trying to build efficient systems, it is generally impossible to use
reasoners purely as black-box components; instead it is almost always
necessary to connect the reasoning engine to the underlying domain
model.  This code has to use the extension facilities of the reasoner
and must therefore typically be written in Common Lisp; to make it
useful for the *Poem* language, "reverse" bindings to the *Iliad*
runtime have to be written as well.  Writing these bindings correctly
requires a deep understanding of the way in which partial
continuations and continuation marks are used in the semantics of
*Poem* (and the VM) to enable non-deterministic computations,
otherwise subtle bugs can arise where the state of the reasoners and
the state of the *Poem* program are no longer synchronized.  In
summary, the presence of the virtual machine added a lot of overhead
for the programmer.

Therefore, this implementation uses a different strategy: it
implements a subset of *Poem* as an internal domain-specific language
on top of Common Lisp.  To make this feasible, several features of the
original *Poem* specification are not supported in *Iliad*:

* Non-deterministic computations are always executed using a
  depth-first chronological backtracking strategy; it is no longer
  possible to influence the control flow of a non-deterministic
  program using declarative search strategies.

* Currently only functions may contain non-deterministic code;
  non-deterministic constructs in method bodies are not correctly
  processed.  It is, however, permissible to call non-deterministic
  functions from methods.  This restriction is due to the manner in
  which the partial CPS transformation of the program is performed and
  will likely be removed in the future.
  
* The reasoning mechanism is only invoked for predicates wrapped
  inside a `holds` form, i.e., it is necessary to write `(if (holds (p
  0)) ...)` instead of `(if (p 0) ...)` when validity of the `(p 0)`
  form should be decided by the reasoning mechanism instead of the
  programming language.
  
On the positive side, the implementation choices for the new *Iliad*
version have led to several important improvements:

* The performance and memory consumption of *Iliad* has been
  significantly improved; it should now be possible to run *Iliad*
  also on resource-constrained devices such as the marXbot or
  smartphones.  (Of course, some reasoners are not well suited for
  these environments.) 

* *Iliad* now contains a blackboard system based on
  [GBBOpen](http://gbbopen.org/) that greatly facilitates the
  integration and coordination of different reasoning mechanisms.
   
* *Iliad* now integrates a hierarchical reinforcement learning system
   based on
   [Concurrent ALisp](http://www.github.com/hoelzl/programmable-reinforcement-learning).

* *Iliad* supports specialized ontology reasoning using the
   [PowerLoom reasoner](http://www.isi.edu/isd/LOOM/PowerLoom/).
   
* *Iliad* can now use the constraint-solving features of
   [Screamer](https://github.com/hoelzl/screamer).
   

<!--
Blackboard System - Achilles
----------------------------

<p align="right">
  <i>
    By god, what heroic gifts you set your heart on—<br/>
	the great Achilles’ team!<br/>
	They’re hard for mortal men to curb or drive,<br/>
	for all but Achilles-his mother is immortal.<br/><br/>
  </i>
  —Homer. The Iliad.
</p>

*Achilles* is the blackboard systems that coordinates the different
reasoning engines available in the *Iliad* runtime.  It is based on
the [GBBOpen](http://gbbopen.org/) blackboard system.


Logical Reasoning - Odysseus
----------------------------

<p align="right">
  <i>
    But Odysseus, cool tactician, tried to calm him:<br/>
    “Achilles, son of Peleus, greatest of the Achaeans,<br/>
	greater than I, stronger with spears by no small edge—<br/>
	yet I might just surpass you in seasoned judgment<br/>
	by quite a lot, since I have years on you<br/>
	and I know the world much better...<br/><br/>
  </i>
  —Homer. The Iliad.
</p>

*Odysseus* is the implementation of the logical reasoning subsystem of
the *Poem* language, providing support for specifying (definite)
knowledge about the world, reasoning services and strategies.  It uses
Mark Stickel's [Snark](https://github.com/hoelzl/snark) theorem prover
as the main logical inference engine and
[PowerLoom](http://www.isi.edu/isd/LOOM/PowerLoom/) for ontological
reasoning.

Reinforcement Learning - Hector
-------------------------------

<p align="right">
  <i>
    And tall Hector nodded, his helmet flashing:<br/>
	“All this weighs on my mind too, dear woman.<br/>
	But I would die of shame to face the men of Troy<br/>
	and the Trojan women trailing their long robes<br/>
	if I would shrink from battle now, a coward.<br/>
	Nor does the spirit urge me on that way.<br/>
	I’ve learned it all too well.<br/><br/>
  </i>
  —Homer. The Iliad.
</p>

*Iliad* integrates a modified version of the
[Concurrent ALisp](http://www.github.com/hoelzl/programmable-reinforcement-learning)
DSL.  Currently the concurrency features are only supported on Allegro
Common Lisp; other Lisp implementations are currently restricted to
the single-threaded *ALisp* variant.

Constraint-Solving and Non-Determinism - Bold Dancer
----------------------------------------------------

<p align="right">
  <i>
    But Sarpedon hurled next with a flashing lance<br/>
	and missed his man but he hit the horse Bold Dancer,<br/>
	stabbing his right shoulder and down the stallion went,<br/>
	screaming his life out, shrieking down in the dust<br/>
	as his life breath winged away.<br/><br/>
  </i>
  —Homer. The Iliad.
</p>

*Bold Dancer* is the subsystem that contains support for
non-deterministic program execution and control flow.
-->

Installation and Execution
--------------------------

I currently provide neither precompiled packages nor scripts to run
*Iliad* from the command line.  Instead you have to download the
sources and run *Iliad* from within your Lisp implementation of
choice.  Once the *Iliad* implementation becomes more stable I will
make precompiled versions available.

### Prerequisites

To run *Iliad* you need:

* One of the supported Lisp implementations (ABCL, CCL, CMUCL or SBCL,
  see below for the exact versions that I am using).  Unless you have
  specific requirements, CCL or SBCL are recommended.
* [ASDF 2](http://common-lisp.net/project/asdf/). This is already be
  included in all supported Lisp implementations.
* [Quicklisp](http://www.quicklisp.org/) (If you install the required
  packages by hand you could dispense with Quicklisp, but this is not
  something I would recommend.)

### Installing from sources

You interact with *Iliad* from the read-eval-print loop of your Lisp
system.  To install *Iliad* from sources you have to perform the
following steps.

* Download the sources of the latest *Iliad* release from the github
  page at https://github.com/hoelzl/Iliad/tags and unpack them in a
  location where ASDF can find them.  (To simplify updating to newer
  versions it's even better if you checkout the master branch with
  `git clone git://github.com/hoelzl/Iliad.git` or one of the other
  methods given on the project page (https://github.com/hoelzl/Iliad).
  If you are feeling adventurous and want to get the latest features
  you can checkout the development branch instead.)

* Add the directories in which you have installed *Iliad* to ASDF's
  search path. you might have to add a form like
  <pre>
    (:source-registry
        (:tree (:home "Prog/Lisp/Hacking/"))
        (:tree (:home "Prog/Lisp/Imported-Projects/"))
        :inherit-configuration)</pre>
  to the file `~/.config/common-lisp/source-registry.conf` on
  Linux/Unix/OSX, or to 
  `%HOME%\AppData\Local\common-lisp\config\source-registry.conf`
  on Windows.
  
* Start your Lisp implementation and enter the following command:
  <pre>(asdf:load-system :iliad)</pre>
  This builds and loads all dependencies and the *Iliad* system.

### Running the tests

To run the unit test suite for *Odysseus*, enter the commands

    (in-package #:poem-user)
    (asdf:load-system :iliad-tests)
	(run-all-tests)
    
after loading the `poem-tests` system.  Currently this runs the test
suites for Screamer and Snark; in particular the tests for Snark will
take a long time.

### Running an example application

There is a simple example program available from [here](https://github.com/hoelzl/WasteRemoval).


Supported Lisp Implementations
------------------------------

*Iliad* has been tested on the folowing implementations running on OSX:

* Clozure Common Lisp: Version 1.8-r15378M  (DarwinX8664)
* CMU Common Lisp: 20c release-20c (20C Unicode)
* SBCL: 1.0.58
* Armed Bear Common Lisp: 12.1 
* Allegro Common Lisp: 9.0 [Mac OS X (Intel)] (Jun 24, 2013 17:07)

It should be straightforward to port *Iliad* to other Lisp
implementations or operating systems.

The following Lisp implementations don't seem to work:

* ECL: 12.7.1: Fails with an internal error while compiling Snark.
  **TODO** Check whether this has been fixed.

I haven't tried running *Iliad* on LispWorks, CLisp or any other
Lisp implementation.  Reports and bug fixes are always welcome.


The Workflow for the *Poem* Project
-----------------------------------

<p align="right">
  <i>
    The work done, the feast laid out, they ate well<br/>
    and no man’s hunger lacked a share of the banquet.<br/><br/>
  </i>
  —Homer. The Iliad.
</p>

I am currently experimenting with the git-flow branching model for
*Poem*.  Please see the article
"[A successful Git branching model](http://nvie.com/posts/a-successful-git-branching-model/)"
for details.  Furthermore, I try to write the commit messages loosely
based on the
[Note About Git Commit Messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
from tbaggery.


About this Document
-------------------

<p align="right">
  <i>
    No one should ever let such nonsense pass his lips,<br/>
    no one with any skill in fit and proper speech—<br/><br/>
  </i>
  —Homer. The Iliad.
</p>


All quotes from the Iliad are taken from the Penguin Classics edition
translated by Robert Fagles.  The HTML markup for the quotes uses the
old-fashioned ```align="right"``` style, since CSS does currently not
seem to work for the Github renderer.
