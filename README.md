# Sudoku Solver 🧩
This project was developed under the Logic For Programming course of the Bachelors Degree in Computer Science and Engineering, at Instituto Superior Técnico, Lisbon.

We developed a sudoku solver using SWI-Prolog.

### Table of content

- [Getting Started](#getting_started)
- [SWI-Prolog](#swi-prolog)
- [Contributors](#contributors)
- [Show you Support](#support)


<a name="getting_started"> 
	
##  🚀 Getting Started

</a>

1. If you don't have SWI-Prolog:

If you are running on MacOS and you have MacPorts or homebrew, just go [here](https://www.swi-prolog.org/build/macos.html).

Otherwise, you can download it [here!](https://www.swi-prolog.org/download/stable)

2. Download the project [here!](https://github.com/marianasrv/sudoku-solver/archive/main.zip) and unzip at a desired directory.

3. To run the project:

On Mac, go to the root folder of the project on terminal and run:
```
swipl -l projeto.pl
```

On Windows:

<b>Double-click</b> the <code>projeto.pl</code> file to load it in the explorer. This will start SWI-Prolog. More info [here](https://www.swi-prolog.org/FAQ/LoadProgram.html).

3. To solve a sudoku, give as input any unsolved sudoku as a list of list. For example, below you can see how you solve the puzzle P:

```
?- P = [[[ ],[3],[ ],[ ],[ ],[1],[ ],[ ],[ ]],
[[ ],[ ],[6],[ ],[ ],[ ],[ ],[5],[ ]],                                         
[[5],[ ],[ ],[ ],[ ],[ ],[9],[8],[3]],                                         
[[ ],[8],[ ],[ ],[ ],[6],[3],[ ],[2]],                                         
[[ ],[ ],[ ],[ ],[5],[ ],[ ],[ ],[ ]],                                          
[[9],[ ],[3],[8],[ ],[ ],[ ],[6],[ ]],                                          
[[7],[1],[4],[ ],[ ],[ ],[ ],[ ],[9]],                                          
[[ ],[2],[ ],[ ],[ ],[ ],[8],[ ],[ ]],                                         
[[ ],[ ],[ ],[4],[ ],[ ],[ ],[3],[ ]]], resolve(P, Sol), write_puzzle(Sol).
```

The output should be:

```
[[8],[3],[2],[5],[9],[1],[6],[7],[4]]
[[4],[9],[6],[3],[8],[7],[2],[5],[1]]
[[5],[7],[1],[2],[6],[4],[9],[8],[3]]
[[1],[8],[5],[7],[4],[6],[3],[9],[2]]
[[2],[6],[7],[9],[5],[3],[4],[1],[8]]
[[9],[4],[3],[8],[1],[2],[7],[6],[5]]
[[7],[1],[4],[6],[3],[8],[5],[2],[9]]
[[3],[2],[9],[1],[7],[5],[8],[4],[6]]
[[6],[5],[8],[4],[2],[9],[1],[3],[7]]

P = [[[], [3], [], [], [], [1], [], []|...], [[], [], [6], [], [], [], []|...], [[5], [], [], [], [], []|...], [[], [8], [], [], []|...], [[], [], [], []|...], [[9], [], [...]|...], [[7], [...]|...], [[]|...], [...|...]],
Sol = [[[8], [3], [2], [5], [9], [1], [6], [...]|...], [[4], [9], [6], [3], [8], [7], [...]|...], [[5], [7], [1], [2], [6], [...]|...], [[1], [8], [5], [7], [...]|...], [[2], [6], [7], [...]|...], [[9], [4], [...]|...], [[7], [...]|...], [[...]|...], [...|...]] .
```


<a name="swi-prolog"> 
	
## 👩‍💻 SWI-Prolog

</a>
This project is powered by SWI-Prolog.

A few resources to get you started if this is your first SWI-Prolog project:

- [Getting Started](https://www.swi-prolog.org/pldoc/man?section=quickstart)

For help getting started with SWI-Prolog,check
[online documentation](https://www.swi-prolog.org/pldoc/doc_for?object=manual).
On their website, you can also find tutorials and more useful information!

<a name="contributors"> 
  
## Contributors

</a>

<a href="https://github.com/marianasrv">
	<img src="https://github.com/marianasrv.png" width="80" style="border-radius:50%">
</a>

<a name="support"> 
	
## Show your support 

</a>
:star: Star me on GitHub — it helps!





