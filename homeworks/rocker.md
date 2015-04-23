---
layout: default
title: Setting up R
---

Last Update: 3/10/2015

We will use [Rocker](https://github.com/rocker-org/rocker), a project built on top of
[Docker](https://www.docker.com/) to manage our software installation. This will provide you with a working installation of R, and the Rstudio IDE, along with a lot
of packages providing analysis tools and datasets we will use throughout the semester. You
can read more about Rocker in [this introduction](http://dirk.eddelbuettel.com/blog/2014/10/23/)

These instructions are essentially following [this document](https://github.com/rocker-org/rocker/wiki/Using-the-RStudio-image).

#Setting up Docker

Install [Docker](https://www.docker.com/) according to the instructions [for your system](https://docs.docker.com/installation/). For Mac and Windows users you will
need to install `boot2docker` to setup a lightweight VM that runs Docker itself.

**Exercise 1**: Check that docker works:

{% highlight bash %}
docker run hello-world
{% endhighlight %}

Finally, Mac and Windows make a note of the IP address assigned by `boot2docker`, by typing
on a new terminal window:

{% highlight bash %}
boot2docker ip
{% endhighlight %}

#Setting up the rOpenSci Docker container

Download and run the [`rOpenSci`](https://registry.hub.docker.com/u/rocker/ropensci/) Docker container.

##Permissions
Note: you don't need to use `sudo` on Mac OSX. Linux users might want to add their user to the docker group to avoid having to use sudo. To do so, just run

{% highlight bash %}
sudo usermod -a -G docker <username>
{% endhighlight %}
You may need to login again to refresh your group membership.

To download and run:

{% highlight bash %}
sudo docker run -d -p 8787:8787 rocker/ropensci
{% endhighlight %}

This will take a while the first time you download it. After the download `Rstudio Server` will start (invisibly).

#Starting Rstudio

You will use Rstudio through your web browser. Navigate to `http://<ip_address>:<port>` where
`<ip_address>` is the IP address you noted in the previous step and port is the port assigned to
the server by the `-p` flag in the `docker run` command (8787 in the call we used above).
For example: `http://192.168.59.103:8787`.

Sign-in with username `rstudio` and password `rstudio`. 

#Try it out

The `Rstudio` IDE is divided into multiple panes. R is an interactive environment for data analysis.
An interactive R session runs in the **Console** pane in Rstudio. You can enter R commands there:

{% highlight r %}
> Sys.Date()
> data(cars)
> plot(cars$dist, cars$speed)
{% endhighlight %}

The last command will make a scatter plot on the **Plots** pane.

#Stopping the container

To stop the running docker container, you need to first find out its `CONTAINER ID`, and then
run `docker stop`. (You only need the first couple of characters in the ID).

{% highlight bash %}
docker ps
docker stop 8a
{% endhighlight %}

#Sharing files with host machine

For our projects and homeworks you will need to turn in files you create during your analysis (e.g., scripts, plots, reports). To do so, you will need to share files between the docker VM and your host machine by adding
the `-v` argument to the docker call. You can read more about it [here](https://github.com/rocker-org/rocker/wiki/Sharing-files-with-host-machine).

#Final caveat

We will most likely fork the `ropensci` container for the purposes of this class. You will probably need to re-install another container.

#Class image

We will be working from a docker image that extends the `ropensci`
container. To use this please use the following command:

{% highlight bash %}
docker run -d -p 8787:8787 -v <local_path>:/home/rstudio hcorrada/introdatascidocker
{% endhighlight %}

Here `<local_path>` corresponds to a path in your local machine that
will be mapped to the home directory in the docker container running
rstudio.

You can find more information about this docker container
[here](https://registry.hub.docker.com/u/hcorrada/introdatascidocker/)

I will announce updates to the image on piazza.

