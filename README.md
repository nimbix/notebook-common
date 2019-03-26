# notebook-common
Tools to add authenticated Jupyter Notebooks to images for CentOS 7+ and Ubuntu 16.04+

# Adding Jupyter Notebook to your image

**Note: updates to packages needed to comprise the notebook-common offering and the dependency issues arising mean that 
Ubuntu Trusty and CentOS 6 are no longer supported**
 
To add Jupyter Notebook capabilities to your Ubuntu-based Docker image:

```bash
ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh && rm -f /tmp/install-ubuntu.sh
```

To add Jupyter Notebook capabilities to your CentOS-based Docker image:

```bash
ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-centos.sh /tmp/install-centos.sh
RUN bash /tmp/install-centos.sh && rm -f /tmp/install-centos.sh
```

To install Python 3 notebooks pass the single argument `-p` to the install script above.


# Executing a Jupyter Notebook

## Example With activation script

```
/usr/local/bin/nimbix_notebook -s /usr/local/scripts/myscript
```

## Example with requirements.txt

```
/usr/local/bin/nimbix_notebook -r ${HOME}/requirements.txt
```

## Example with Anaconda environment

```
/usr/local/bin/nimbix_notebook -c my-conda-env
```

# Accessing the Jupyter Notebook
Once started, the notebook may be accessed by clicking on the running application on the JARVICE dashboard. Sessions are authenticated using randomly generated tokens.

# Local testing

## Example starting notebook on local machine

```
docker run --rm -h JARVICE -p 8443:443 mycontainer /usr/local/bin/nimbix_notebook -l
```

(Replace ```mycontainer``` with the name of the Docker image you built locally.)

## Connecting to local notebook
To connect to the above example container running the notebook, open a browser and browse to [http://localhost:8443](http://localhost:8443). Note: Local testing does not use https:// or password/token authentication.
