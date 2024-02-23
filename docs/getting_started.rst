.. _getting-started:

Getting Started
===============

Compatibility
-------------
* Python: 2.6, 3.5+ (for version <= 1.3)
* Python: 3.8+ (for version >= 2.0)
* Mattermost: 4.0+

Installation
------------

PyPi (pip)
##########
The recommended method to install `mmpy_bot_mk2` is via pip:

.. code-block:: python

    pip install -U mmpy_bot_mk2

Git Repo
########
#. Clone the git repository:

    .. code-block:: bash

        $ git clone git@github.com:movax01h/mmpy_bot_mk2.git

#. Install requirements:

    .. code-block:: bash

        $ pip install -r requirements.txt

Running the bot
---------------

We recommend creating an `entrypoint` file for executing the bot, which will
look something like this:

    .. code-block:: python

        #!/usr/bin/env python

        from mmpy_bot_mk2 import Bot, Settings, ExamplePlugin, WebHookExample
        # from my_plugin import MyPlugin  <== Example of importing your own plugin, don't forget to add it to the plugins list.

        bot = Bot(
            settings=Settings(
                MATTERMOST_URL = "http://<mattermost_server_url>",
                MATTERMOST_PORT = 443,
                BOT_TOKEN = "<your_bot_token>",
                BOT_TEAM = "<team_name>",
                SSL_VERIFY = True,
            ),
            plugins=[ExamplePlugin(), WebHookExample()],
        )
        bot.run()

You can then simply launch the bot with `python entrypoint.py`.
For more information on configuring bot settings and plugins, please see `settings.py <https://github.com/movax01h/mmpy_bot_mk2/blob/main/mmpy_bot/settings.py>`_ and the :ref:`plugins <plugins>` page.

Container
#########

A container image is available at `movax01h/mmpy_bot_mk2
<https://hub.docker.com/r/movax01h/mmpy_bot_mk2>`_.
Using your preferred container management software (Docker/Podman), you can
pull the image and run it using the following steps:

#. Pull the image from the Docker repository:

    .. code-block:: bash

        $ podman pull docker.io/movax01h/mmpy_bot_mk2

#. Run the container with defined environment variables:

    .. code-block:: bash

        $ podman run -d --name=mmpy_bot_mk2 --network=host -e MATTERMOST_URL=<mattermost_server_url> -e MATTERMOST_PORT=<mattermost_server_port> -e BOT_TOKEN=<bot_token> docker.io/jneeven/mmpy_bot

You can also find an example `docker-compose.yml` file `here
<https://github.com/movax01h/mmpy_bot_mk2/blob/master/docker-compose.yml>`_.

Customizing your bot
####################

Getting your bot running is only the beginning. The real fun begins with
writing plugins to get it functioning exactly how you want it! Head on over
to the :ref:`plugins <plugins>` page to get started.

Fetch mmpy_bot_mk2 version
##########################

To check your installed version of `mmpy_bot_mk2`, simply open a Python
interpreter and run the following commands:

    .. code-block:: python

        import mmpy_bot_mk2
        print(mmpy_bot_mk2.__version__)
