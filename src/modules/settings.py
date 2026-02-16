from pathlib import Path
from .base import BaseModule

class SettingsModule(BaseModule):
    def run(self, work_dir: Path):
        self.logger.info("Processing Settings.apk...")
        
        # Corresponds to Shell: if [[ ${is_port_eu_rom} == true ]]
        is_eu = getattr(self.ctx, "is_eu_port", False)

        if is_eu:
            self.logger.info("  -> Applying EU specific patches...")
            # setting_unlock_google_buttion (Unlock Google Button)
            self.smali_patch(work_dir, 
                iname="MiuiSettings.smali", 
                method="updateHeaderList", 
                regex_replace=(r"sget-boolean\s+(v\d+|p\d+),.*IS_GLOBAL_BUILD:Z", r"const/4 \1, 0x1")
            )
