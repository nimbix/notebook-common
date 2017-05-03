# notebook-common
Tools to add authenticated Jupyter Notebooks to images

# Adding Jupyter Notebook to your image
To add Jupyter Notebook capabilities to your Ubuntu-based Docker image:

```bash
ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh && rm -f /tmp/install-ubuntu.sh
```

To install Python 3 notebooks pass the single argument "3" to the install script above.

# Executing a Jupyter Notebook

## Example With activation script

```
/usr/local/bin/nimbix_notebook -s /usr/local/scripts/myscript
```

## Example with requirements.txt

```
/usr/local/bin/nimbix_notebook -r /home/nimbix/requirements.txt
```

# Accessing the Jupyter Notebook
Once started, the notebook may be accessed via HTTPS remotely on port 443; username is always **nimbix** and password is the password assigned to the job, which can be displayed in the portal.

# Local testing

## Example starting notebook on local machine

```
docker run --rm -h JARVICE -p 8443:443 mycontainer /usr/lib/JARVICE/tools/sbin/init /usr/local/bin/nimbix_notebook
```

(Replace ```mycontainer``` with the name of the Docker image you built locally.)

## Connecting to local notebook
To connect to the above example container running the notebook, open a browser and browse to [https://localhost:8443](https://localhost:8443).  When prompted, enter username **nimbix** and password **jarvice** (all lowercase).  Note that when deployed in the Nimbix Cloud the password is replaced with a randomly generated on available from the portal.

