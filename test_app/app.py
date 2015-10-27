import click
import pandas as pd

@click.command()
@click.option('--count', default=1, help='Number of rows.')
@click.option('--name', prompt='Your name',
              help='The person to greet.')
@click.option('--greeting', default='Hello', help='Greeting string to use.')
def hello(count, name, greeting):
    """Simple program that greets NAME for a total of COUNT times."""
    rows = []
    for x in range(count):
        rows.append({'greeting': greeting, 'name': name})

    df = pd.DataFrame.from_dict(rows)
    click.echo(df)

if __name__ == '__main__':
    hello()
