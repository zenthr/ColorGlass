#!/bin/bash
#SBATCH --job-name=Order
#SBATCH --output=stdout.%j
#SBATCH --account=122804261043
#SBATCH --time=4:00:00
#SBATCH --ntasks=1
#SBATCH --mem=24G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=zenthrelin@gmail.com
top -b -u $USER > MemLogNTask1.%j &
./Order.exe
