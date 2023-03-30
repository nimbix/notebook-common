# notebook-common
Tools to add authenticated Jupyter Notebooks to images for CentOS 7+ and Ubuntu 16.04+

# Adding Jupyter Notebook to your image

**Note: updates to packages needed to comprise the notebook-common offering and the dependency issues arising mean that 
Ubuntu Trusty and CentOS 6 are no longer supported**
 
To add Jupyter Notebook capabilities to your Docker image:

```bash
ADD https://raw.githubusercontent.com/nimbix/notebook-common/${BRANCH:-master}/install-notebook-common /tmp/install-notebook-common
RUN bash /tmp/install-notebook-common -b "$BRANCH" -c && rm /tmp/install-notebook-common
```

To install Python 3 notebooks pass the single argument `-3`:

```bash
RUN bash /tmp/install-notebook-common -b "$BRANCH" -c -3 && rm /tmp/install-notebook-common
```

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

## Example setting base URL for the notebook server

```
/usr/local/bin/nimbix_notebook -u my-base-path
```

# Accessing the Jupyter Notebook
Once started, the notebook may be accessed by clicking on the running application on the JARVICE dashboard. 
Sessions are authenticated using randomly generated tokens.

# Local testing

## Example starting notebook on local machine

```
docker run --rm -h JARVICE -p 5902:5902 mycontainer /usr/local/bin/nimbix_notebook -l
```

(Replace ```mycontainer``` with the name of the Docker image you built locally.)

## Connecting to local notebook
To connect to the above example container running the notebook, open a browser and browse to [http://localhost:5902](http://localhost:5902). 
Note: Local testing does not use https:// or password/token authentication.

# AppDef notes
If using the `url` key in the AppDef, set to exactly this value:

```
https://%PUBLICADDR%:5902/tree?token=%RANDOM64%
```

