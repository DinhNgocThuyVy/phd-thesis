# Global warnings suppression script
import warnings
import pandas as pd

# Suppress specific pandas warnings
warnings.filterwarnings("ignore", category=pd.core.common.SettingWithCopyWarning)

# Suppress matplotlib warnings
warnings.filterwarnings("ignore", category=UserWarning, module="matplotlib")

# Suppress numpy warnings
warnings.filterwarnings("ignore", category=RuntimeWarning, module="numpy")

# Suppress seaborn warnings
warnings.filterwarnings("ignore", module="seaborn")

# Generic deprecation warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)
warnings.filterwarnings("ignore", category=FutureWarning)

print("Warning suppression active: All common warnings have been disabled")
