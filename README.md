# notebook-common
Tools to add authenticated Jupyter Notebooks to images

# Adding Jupyter Notebook to your image
To add Jupyter Notebook capabilities to your Ubuntu-based Docker image:

```bash
ADD https://raw.githubusercontent.com/nimbix/notebook-common/master/install-ubuntu.sh /tmp/install-ubuntu.sh
RUN bash /tmp/install-ubuntu.sh && rm -f /tmp/install-ubuntu.sh
```

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

