---
layout: default
title: Setting up R
---

Last Update: 6/19/2015

We will use [Rocker](https://github.com/rocker-org/rocker), a project built on top of
[Docker](https://www.docker.com/) to manage our software installation. This will provide you with a working installation of R, and the Rstudio IDE, along with a lot
of packages providing analysis tools and datasets we will use throughout the semester. You
can read more about Rocker in [this introduction](http://dirk.eddelbuettel.com/blog/2014/10/23/)

These instructions are essentially following [this document](https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image).

#Setting up Docker

Install [Docker](https://www.docker.com/) according to the instructions [for your system](https://docs.docker.com/installation/). For Mac and Windows users you will
need to install `boot2docker` to setup a lightweight VM that runs Docker itself.

To check that docker works:

{% highlight bash %}
docker run hello-world
{% endhighlight %}


#Setting up the course Docker image

We will be working from a docker image that extends the `ropensci`
container provided by the [Rocker project](https://github.com/rocker-org/rocker).  It includes a a working installation of R, and the Rstudio IDE, along with many
packages providing analysis tools and datasets we will use throughout the course. You can read more about Rocker in [this introduction](http://dirk.eddelbuettel.com/blog/2014/10/23/)

This command will start an instance of this image.

{% highlight bash %}
docker run -d -p 8787:8787 -v <local_path>:/home/rstudio --name ids hcorrada/idsdocker
{% endhighlight %}

This will take a while the first time you download it. After the download `Rstudio Server` will start (invisibly).

A couple of things to note:

1. We will use Rstudio server through the web browser. The command `-p 8787:8787` tells docker where you're going to point your browser to run it.

2. Docker runs on a virtual machine, we would like to be able to share files in your local machine with this virtual machine. The `-v` flag does that. Here `<local_path>` corresponds to a path in your local machine that will be mapped to the home directory in the docker virtual machine running rstudio. You can read more about this [here](https://github.com/rocker-org/rocker/wiki/Sharing-files-with-host-machine).

3. We name the instance `ids` so we can refer to it in other commands later on.

#Starting Rstudio

You will use Rstudio through your web browser. First, you need to know what is the address of your virtual machine. You can do this by typing this in a terminal window:

{% highlight bash %}
boot2docker ip
{% endhighlight %}

If, for example, this returned `192.168.59.103` then we can open Rstudio by pointing our web browser to `http://192.168.59.103:8787` (remember we used port `8787` when we started the image).

Sign-in with username `rstudio` and password `rstudio`.

#Try it out

The `Rstudio` IDE is divided into multiple panes. R is an interactive environment for data analysis.
An interactive R session runs in the **Console** pane in Rstudio. You can enter R commands there:

{% highlight r %}
> Sys.Date()
> data(cars)
> View(cars)
> plot(cars$dist, cars$speed)
{% endhighlight %}

The last command will make a scatter plot on the **Plots** pane.

#Stopping the container

To stop and remove the running docker container, write:

{% highlight bash %}
docker stop ids
docker rm ids
{% endhighlight %}


#Permissions
Advanced Note: you don't need to use `sudo` on Mac OSX. Linux users might want to add their user to the docker group to avoid having to use sudo. To do so, just run

{% highlight bash %}
sudo usermod -a -G docker <username>
{% endhighlight %}
You may need to login again to refresh your group membership.

#Git

The course docker image also includes `git` a *version control* program we will use during the course. You will download *all* course materials using `git` and be able to update any changes I make along the way.

Version control will also be useful for reproducibility of your data analyses, also for sharing your analyses and contributing with collaborators.

To get started we will create a new Rstudio project by clicking on `File->New Project...`

and selecting `Version Control` to build the project from our course materials.

Select `Git` and enter the course repositories URL:

[https://github.com/hcorrada/MTEC_CADi2015.git](https://github.com/hcorrada/MTEC_CADi2015.git)

This will download all the course materials to your current directory.

We will later see more information on how to use `git`.
