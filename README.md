# 2PDQN for testing

This repository is for testing a 2-player xitari/ale + alewrap that I am going to make that support more games as a first step to experimenting on different network structures in the 2 player domain, meow!

# DeepMind Atari Deep Q Learner for 2 players

This repository hosts the code to reproduce the experiments in the article "Multiagent Cooperation and Competition with Deep
Reinforcement Learning". It is based on DeepMind's [original code](https://sites.google.com/a/deepmind.com/dqn/), that was modified to support two players. **NB!** Currently only Pong game in two-player mode is supported, support for other games and one-player mode is untested.

Gameplay videos can be found here: https://www.youtube.com/playlist?list=PLfLv_F3r0TwyaZPe50OOUx8tRf0HwdR_u

Installation instructions
-------------------------

The installation requires Linux with apt-get.

Note: In order to run the GPU version of DQN, you should additionally have the
NVIDIA® CUDA® (version 5.5 or later) toolkit installed prior to the Torch
installation below.
This can be downloaded from https://developer.nvidia.com/cuda-toolkit
and installation instructions can be found in
http://docs.nvidia.com/cuda/cuda-getting-started-guide-for-linux

To train DQN on Atari games, the following components must be installed:
* LuaJIT and Torch 7.0
* nngraph
* Xitari (fork of the Arcade Learning Environment (Bellemare et al., 2013))
* AleWrap (a lua interface to Xitari)

To install all of the above in a subdirectory called 'torch', it should be enough to run

    ./install_dependencies.sh

from the base directory of the package.


Note: The above install script will install the following packages via apt-get:
build-essential, gcc, g++, cmake, curl, libreadline-dev, git-core, libjpeg-dev,
libpng-dev, ncurses-dev, imagemagick, unzip, libqt4-dev.

In addition following Lua components are installed to 'torch' subdirectory: 
luajit-rocks, cwrap, paths, torch, nn, cutorch, cunn, luafilesystem, penlight, sys, 
xlua, image, env, qtlua, qttorch, nngraph, lua-gd. 

Training
--------

To run training for a game:

    ./run_gpu2 <game name>

Following games are supported:
 * `Pong2Player` - cooperative game (\rho = -1)
 * `Pong2Player075` - transition (\rho = -0.75)
 * `Pong2Player05` - transition (\rho = -0.5)
 * `Pong2Player025` - transition (\rho = -0.25)
 * `Pong2Player0` - transition (\rho = 0)
 * `Pong2Player025p` - transition (\rho = 0.25)
 * `Pong2Player05p` - transition (\rho = 0.5)
 * `Pong2Player075p` - transition (\rho = 0.75)
 * `Pong2PlayerVS` - competitive game (\rho = 1)

During training the snapshots of networks of both agents are written to `dqn/` folder. These are named `DQN3_0_1_<game name>_FULL_Y_A_<epoch>.t7` and `DQN3_0_1_<game name>_FULL_Y_B_<epoch>.t7`. One epoch is defined as 250,000 steps and they are numbered starting from 0. **NB!** One epoch snapshot takes about 1GB, therefore for 50 epochs reserve 50GB free space.

Testing
-------

To run testing for one episode:

    ./test_gpu2 <game name> <epoch>
    
To run testing with different seeds (by default 10):

    ./test_gpu2_seeds <game name> <epoch>

To run testing with different seeds (by default 10), for all epochs (default 49):

    ./test_gpu2_versions <game name>
    
To run all experiments at once:

    ./test_schemes
    
All these scripts write file `dqn/<game name>.csv`, that contains following game statistics:
 * *Epoch* - epoch number,
 * *Seed* - seed used for this run,
 * *WallBounces* - total number of wall-bounces in this run,
 * *SideBounce* - total number of paddle-bounces in this run,
 * *Points* - total number of points (lost balls) in this run,
 * *ServingTime* - total serving time in this run,
 * *RewardA* - total reward of player A,
 * *RewardB* - total reward of player B.

**NB!** All scripts append to this file, so after several runs you might want to delete irrelevant lines.

Extracting training statistics
----------------------------

To plot training history:

    ./plot_2results <game name> [<epoch>]
    
Following plots are shown for both agents:
 * average reward per game during testing,
 * total count of non-zero rewards during testing,
 * number of games played during testing,
 * average Q-value of validation set.

To extract training statistics to file:

    ./extract_data <game name> <epoch>

This produces files `dqn/<game name>_history_A.csv` and `dqn/<game name>_history_B.csv`. These files contain following columns:
 * *Epoch* - testing phase number, divide by 2 to get true epoch,
 * *Average reward* - average reward per game during testing,
 * *Reward count* - total count of non-zero rewards during testing,
 * *Episode count* - number of games played during testing,
 * *MeanQ* - average W-value of validation set,
 * *TD Error* - temporal difference error,
 * *Seconds* - seconds since start.

Plotting game statistics
------------------------

Plotting scripts are in folder `plots`. All `.csv` files from `dqn/` folder should be moved there for plotting. 

 * `scatter.py` - plots for figure 7, uses `<game name>.csv` files,
 * `plot.py` - plots for figures 3 and 4, uses `Pong2Player.csv` and `Pong2PlayerVS.csv` files,
 * `plot_history.py` - plots for figure 8, uses `<game name>_history_A.csv` and `<game name>_history_B.csv` files.

**NB!** Be sure to clean up `<game name>.csv` files as explained above.
