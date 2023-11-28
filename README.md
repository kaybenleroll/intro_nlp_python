# intro_nlp_python
This repo contains all the code and materials used by me to run through the Stanza NLP work.

To set up the jupyter output stripping, we need to do the following:

  git config filter.strip-notebook-output.clean 'jupyter nbconvert --ClearOutputPreprocessor.enabled=True --to=notebook --stdin --stdout --log-level=ERROR'

And then add the following to `.gitattributes`

  *.ipynb filter=strip-notebook-output

