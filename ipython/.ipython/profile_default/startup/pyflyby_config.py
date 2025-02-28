"""================================================================
此文件为pyflyby的配置文件
~/.ipython/profile_default/startup
"""

# from IPython import get_ipython
# import subprocess

import pandas as pd
import numpy as np
import visidata as vd

# from rich import print
from rich import pretty
from rich.traceback import install

pretty.install()
install()

pd.set_option("expand_frame_repr", False)


vd = vd.view_pandas


# 利润计算
def percent(original, current):
    percent = (current - original) / original * 100

    print("收益率为 %s" % (percent), "%")


def P(feather):
    df = pd.read_feather(feather)
    return df
